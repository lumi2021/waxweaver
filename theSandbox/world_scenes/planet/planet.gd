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

var hasPlayer = false

func _ready():
	set_physics_process(false)
	generateEmptyArray()
	noise.seed = randi()
	generateTerrain()
	
	$isVisible.rect = Rect2(SIZEINCHUNKS*-32,SIZEINCHUNKS*-32,SIZEINCHUNKS*64,SIZEINCHUNKS*64)
	
########################################################################
############################## ORBITING ################################
########################################################################

func _process(delta):
	##Orbit##
	if orbiting != null:
		
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
		
		if hasPlayer:
			GlobalRef.player.scrollBackgroundsSpace(orbitVelocity*-1,delta)
		
		
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
	for chunk in visibleChunks:
		if tick % 4 != chunk.id4:
			continue
		
		var changesArray = chunk.tickUpdate()
		var committedChanges = {}
		
		for d in changesArray:
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
	
	#if changeCommit.size() > 0:
	#	print(changeCommit)
	
	for change in changeCommit.keys():
		
		DATAC.setTileData(change.x,change.y,changeCommit[change])
		DATAC.setTimeData(change.x,change.y,GlobalRef.globalTick)
		
		var foundChunk = chunkArray2D[change.x/8][change.y/8]
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
			DATAC.setPositionLookup(x,y,getBlockPosition(x,y))

func generateTerrain():
	match planetType:
		"forest":BlockData.theGenerator.generateForestPlanet(DATAC,noise)
		"lunar":BlockData.theGenerator.generateLunarPlanet(DATAC,noise)
		"sun":BlockData.theGenerator.generateSunPlanet(DATAC,noise)
	
	
	return

func createChunks():
	for x in range(SIZEINCHUNKS):
		chunkArray2D.append([])
		for y in range(SIZEINCHUNKS):
			var newChunk = chunkScene.instantiate()
			newChunk.pos = Vector2(x,y)
			newChunk.position = (Vector2(x,y) * 64) - Vector2(SIZEINCHUNKS*32,SIZEINCHUNKS*32)
			chunkContainer.add_child(newChunk)
			chunkArray2D[x].append(newChunk)
	set_physics_process(true)
	
	
func clearChunks():
	set_physics_process(false)
	for chunk in chunkContainer.get_children():
		chunk.queue_free()
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
	#Returns 7 for cave air or 0 for surface air
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

func _on_is_visible_screen_entered():
	createChunks()
	system.reparentToPlanet(GlobalRef.player,self)
	hasPlayer = true
	GlobalRef.player.velocity -= orbitVelocity * 10
	reverseOrbitingParents()


func _on_is_visible_screen_exited():
	clearChunks()
	system.dumpObjectToSpace(GlobalRef.player)
	GlobalRef.player.velocity += orbitVelocity
	hasPlayer = false
	clearOrbitingParents()

