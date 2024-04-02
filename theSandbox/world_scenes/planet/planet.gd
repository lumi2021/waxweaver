extends Node2D
class_name Planet

var system = null

@export var planetType : String = "forest"
@export var SIZEINCHUNKS :int = 16 # (size * 8)^2 = number of tiles

@onready var DATAC = $PLANETDATA

@onready var chunkContainer = $ChunkContainer
@onready var entityContainer = $EntityContainer

@export var mass := 10000.0
@export var orbiting : Node2D
@export var orbitSpeed :float = 0.0001
@export var orbitDistance :int = 0
var orbitPeriod = 0
var orbitReverse = false
var orbitVelocity = Vector2.ZERO

var chunkScene = preload("res://world_scenes/chunk/chunk.tscn")

var centerPoint = Vector2.ZERO

#Noise
var noise = FastNoiseLite.new()

var tick = 0

var chunkArray2D = []

var visibleChunks = []

var chunkDictionary = {}

var tickAlive = 0

signal doneEditingTiles

func _ready():
	
	if orbiting != null:
		position = orbiting.position + Vector2(orbitDistance,0).rotated(orbitPeriod)
		position.x = int(position.x)
		position.y = int(position.y)
	
	
	set_physics_process(false)
	generateEmptyArray()
	noise.seed = randi()
	generateTerrain()
	
	
########################################################################
############################## ORBITING ################################
########################################################################

func _process(delta):
	##Orbit##
	if orbiting != null and tickAlive > 240:
		
		var posHold = position
		
		if !orbitReverse:
			orbitPeriod += orbitSpeed * 0.0001 * (delta*60)

			position = orbiting.position + Vector2(orbitDistance,0).rotated(orbitPeriod)
			position.x = int(position.x)
			position.y = int(position.y)
			
			orbitVelocity = position - posHold
		else:
			
			posHold = orbiting.position
			
			orbitPeriod += orbitSpeed * 0.0001 * (delta*60)
		
			orbiting.position = position + Vector2(-orbitDistance,0).rotated(orbitPeriod)
			orbiting.position.x = int(orbiting.position.x)
			orbiting.position.y = int(orbiting.position.y)
		
			orbitVelocity = orbiting.position - posHold
		
		if orbitPeriod > PI * 2:
			orbitPeriod - (PI * 2)
	
	tickAlive += 1
		
func reverseOrbitingParents():
	if orbiting == null:
		return
	orbitReverse = true
	orbiting.reverseOrbitingParents()

func clearOrbitingParents():
	orbitReverse = false
	if orbiting != null:
		orbiting.clearOrbitingParents()

########################################################################
########################## CHUNK SIMULATION ############################
########################################################################

func _physics_process(delta):
	tick += 1
	DATAC.setGlobalTick(GlobalRef.globalTick)
	DATAC.getGlobalTick()
	var shouldUpdateLight = 0
	for key in chunkDictionary:
		var chunk = chunkDictionary[key]
		if tick % 4 != chunk.id4:
			continue
		
		var changesArray = chunk.tickUpdate()
		var committedChanges = {}
		
		for d in changesArray:
			if d is bool:
				if d:
					chunk.drawLiquid()
				continue
			var toss = false
			for i in d.keys():
				if committedChanges.has(i):
					toss = true
			if !toss:
				for i in d.keys():
					committedChanges[i] = d[i]
		
		#Updates light
		shouldUpdateLight += int(chunk.MUSTUPDATELIGHT)
		chunk.MUSTUPDATELIGHT = false
		
		editTiles(committedChanges)
	
	#if shouldUpdateLight > 0 and is_instance_valid(GlobalRef.player):
	GlobalRef.player.updateLightStatic()

func editTiles(changeCommit):
	var chunksToUpdate = []
	
	for change in changeCommit.keys():
		var c = changeCommit[change]
		match c:
			-1:
				var save:int = DATAC.getTileData(change.x,change.y)
				DATAC.setTileData(change.x,change.y,airOrCaveAir(change.x,change.y))
				BlockData.breakBlock(change.x,change.y,self,save)
			0:
				DATAC.setTileData(change.x,change.y,airOrCaveAir(change.x,change.y))
				DATAC.setTimeData(change.x,change.y,GlobalRef.globalTick)
			-99999:
				var save:int = DATAC.getBGData(change.x,change.y)
				DATAC.setBGData(change.x,change.y,0)
				BlockData.breakWall(change.x,change.y,self,save)
			_: #Default
				if c < -1:
					DATAC.setBGData(change.x,change.y,abs(c))
				else:
					DATAC.setTileData(change.x,change.y,c)
				DATAC.setTimeData(change.x,change.y,GlobalRef.globalTick)
		
		return
		
		var foundChunk = chunkArray2D[clamp(change.x/8,0,SIZEINCHUNKS-1)][clamp(change.y/8,0,SIZEINCHUNKS-1)]
		if !chunksToUpdate.has(foundChunk):
			chunksToUpdate.append(foundChunk)
		
		#Theres gotta be a way to clean this up
		if int(change.x) % 8 == 0 and change.x > 8:
			var foundChunkLEFT = chunkArray2D[(change.x/8)-1][change.y/8]
			if !chunksToUpdate.has(foundChunkLEFT):
				chunksToUpdate.append(foundChunkLEFT)
		elif int(change.x) % 8 == 7 and change.x < (SIZEINCHUNKS*8)-8:
			var foundChunkRIGHT = chunkArray2D[(change.x/8)+1][change.y/8]
			if !chunksToUpdate.has(foundChunkRIGHT):
				chunksToUpdate.append(foundChunkRIGHT)
			
		if int(change.y) % 8 == 0 and change.y > 8:
			var foundChunkUP = chunkArray2D[change.x/8][(change.y/8)-1]
			if !chunksToUpdate.has(foundChunkUP):
				chunksToUpdate.append(foundChunkUP)
		elif int(change.y) % 8 == 7 and change.y < (SIZEINCHUNKS*8)-8:
			var foundChunkDOWN = chunkArray2D[change.x/8][(change.y/8)+1]
			if !chunksToUpdate.has(foundChunkDOWN):
				chunksToUpdate.append(foundChunkDOWN)
	
	for chunk in chunksToUpdate:
		chunk.drawData()

func setLight(x,y,level): ## Useful for settings dynamic moving lights
	var currentLight = DATAC.getLightData(x,y)
	if level >= abs(currentLight):
		DATAC.setLightData(x,y,level * -1.0)


########################################################################
############################ GENERATION ################################
########################################################################

func generateEmptyArray():
	centerPoint = Vector2(SIZEINCHUNKS*4,SIZEINCHUNKS*4) - Vector2(0.5,0.5)
	
	var s := SIZEINCHUNKS*8
	
	DATAC.createEmptyArrays(s)
	
	for x in range(s):
		for y in range(s):
			# c++
			DATAC.setTileData(x,y,0)
			DATAC.setBGData(x,y,0)
			DATAC.setLightData(x,y,0.0)
			DATAC.setTimeData(x,y,0)
			DATAC.setWaterData(x,y,0.0)
			DATAC.setPositionLookup(x,y,getBlockPosition(x,y))

func generateTerrain():
	match planetType:
		"forest":BlockData.theGenerator.generateForestPlanet(DATAC,noise)
		"lunar":BlockData.theGenerator.generateLunarPlanet(DATAC,noise)
		"sun":BlockData.theGenerator.generateSunPlanet(DATAC,noise)
	
	
	return

func loadChunkArea(pos):
	var radius :int = 9
	var cool = []
	for x in range(radius):
		for y in range(radius):
			var trueCoords :Vector2 = pos + Vector2( x - (radius/2) , y - (radius/2) )
			
			if !chunkDictionary.has(trueCoords):
				var ins = chunkScene.instantiate()
				ins.position = trueCoords
				chunkDictionary[trueCoords] = ins
				chunkContainer.add_child(ins)
			cool.append(trueCoords)
	
	#for chunk in chunkDictionary.keys():
	#	if !cool.has(chunk):
	#		chunkDictionary[chunk].queue_free()
	#		chunkDictionary.erase(chunk)
	
	
func createChunks():
	chunkArray2D = DATAC.createAllChunks(chunkScene,chunkContainer,SIZEINCHUNKS)
	set_physics_process(true)
	
func clearChunks():
	set_physics_process(false)

	chunkContainer.queue_free()
	var new = Node2D.new()
	add_child(new)
	chunkContainer = new
	
	chunkArray2D = []
	visibleChunks = []

########################################################################
################################ MATH ##################################
########################################################################

func getBlockPosition(x,y):
	var angle1 = Vector2(1,1)
	var angle2 = Vector2(-1,1)
	var newPos = Vector2(x,y) - centerPoint
	
	var dot1 = int(newPos.dot(angle1) >= 0)
	var dot2 = int(newPos.dot(angle2) > 0) * 2
	
	return [0,1,3,2][dot1 + dot2]

func getBlockDistance(x,y):
	var quadtrant = DATAC.getPositionLookup(x,y)
	var newPos = Vector2(x,y) - centerPoint
	newPos = newPos.rotated((PI/2)*-quadtrant)
	return -newPos.y

func getBlockRoundedDistance(x,y):
	return (Vector2(x,y) - centerPoint).length()

func airOrCaveAir(x,y):
	var surface = SIZEINCHUNKS*2
	#Returns 1 for cave air or 0 for surface air
	return int(getBlockDistance(x,y) <= surface - 2)

func posToTile(pos):
	var planetRadius = SIZEINCHUNKS * 32 #32 is (chunk size * tile size)/2
	var relativePos = pos + Vector2(planetRadius,planetRadius)
	var sizeInTiles = SIZEINCHUNKS * 8
	
	var tilePos = Vector2(int(relativePos.x)/8,int(relativePos.y)/8)
	if tilePos.x < 0 or tilePos.y < 0 or tilePos.x >= sizeInTiles or tilePos.y >= sizeInTiles:
		return null
	
	return tilePos

func tileToPos(pos):
	var planetRadius = SIZEINCHUNKS * 32
	return (pos * 8) - Vector2(planetRadius,planetRadius) + Vector2(4,4)

########################################################################
############################ VISIBILITY ################################
########################################################################

func loadPlanet():
	#createChunks()
	set_physics_process(true)
	reverseOrbitingParents()
	

func unloadPlanet():
	clearChunks()
	clearOrbitingParents()
	
