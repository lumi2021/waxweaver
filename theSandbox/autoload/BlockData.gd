extends Node

@onready var groundItemScene = preload("res://object_scenes/ground_item/ground_item.tscn")
@onready var blockBreakParticle = preload("res://object_scenes/particles/blockBreak/block_break_particles.tscn")

var theChunker = null
var theGenerator = null

func _ready():
	var ins = CHUNKDRAW.new()
	theChunker = ins
	add_child(ins)
	
	var g = PLANETGEN.new()
	theGenerator = g
	add_child(g)
	
	#theChunker.attemptSpawnEnemy.connect(attemptSpawnEnemy)

func checkForCollision(id):
	var d = theChunker.getBlockDictionary(id)
	return d["hasCollision"]

func checkIfNatural(id):
	var d = theChunker.getBlockDictionary(id)
	return d["natural"]

func breakBlock(x,y,planet,blockID,infoID,doneByPlayer:bool=false):
	
	var data = theChunker.getBlockDictionary(blockID)
	
	spawnBreakParticle(x,y,blockID,data["breakParticleID"],planet,infoID,doneByPlayer)
	spawnGroundItem(x,y,data["itemToDrop"],planet)
	
	planet.editTiles( theChunker.runBreak(planet.DATAC,Vector2i.ZERO,x,y,blockID) )

func breakWall(x,y,planet,blockID):
	if blockID <= 1:
		return
	
	var data = theChunker.getBlockDictionary(blockID)
	spawnBreakParticle(x,y,blockID,data["breakParticleID"],planet,0,true)
	if ItemData.itemExists(-blockID):
		spawnGroundItem(x,y,-blockID,planet)


func spawnGroundItem(tilex:int,tiley:int,id:int,planet):
	
	## special cases ##
	match id:
		-1:
			return
		7: # is tree sapling
			
			if randi() % 30 == 0:
				spawnItemRaw(tilex,tiley,3037,planet)
			
			if randi() % 2 == 0:
				return
		17: # is wheat seed
			if randi() % 6 != 0:
				return
			
		19: # is chair
			id = 6000 + ( planet.DATAC.getInfoData(tilex,tiley) / 4)
		22: # is closed door
			id = 6050 + ( planet.DATAC.getInfoData(tilex,tiley) / 2)
		23: # is open door
			id = 6050 + ( planet.DATAC.getInfoData(tilex,tiley) / 8)
		37: # is potato
			if planet.DATAC.getInfoData(tilex,tiley) >= 4:
				spawnItemRaw(tilex,tiley,37,planet)
				spawnItemRaw(tilex,tiley,37,planet)
		53: # is wool
			id = 3041 + planet.DATAC.getInfoData(tilex,tiley)
			print( planet.DATAC.getInfoData(tilex,tiley) )
		55: # is bed
			id = 6150 # for now
		76: # is glowing orb
			if planet.DATAC.getInfoData(tilex,tiley) == 0:
				return # returns if not fully grown
		83: # wheat
			if planet.DATAC.getInfoData(tilex,tiley) < 2:
				spawnItemRaw(tilex,tiley,17,planet)
				return # deletes if wheat isnt fullygrown
			spawnItemRaw(tilex,tiley,17,planet)
			spawnItemRaw(tilex,tiley,17,planet)
		93: # hidden wire
			id = 6200 + planet.DATAC.getInfoData(tilex,tiley)
	
	var ins = groundItemScene.instantiate()
	ins.itemID = id
	ins.position = planet.tileToPos(Vector2(tilex,tiley))
	planet.entityContainer.add_child(ins)

func spawnItemRaw(tilex:int,tiley:int,id:int,planet,amount:int=1,droppedByPlayer:bool=false,dropDir:int=1):
	# spawns an item without considering special cases
	var ins = groundItemScene.instantiate()
	ins.itemID = id
	if droppedByPlayer:
		ins.droppedByPlayer = 4
		ins.dropvel = Vector2(200*dropDir,-100)
	ins.amount = amount
	ins.position = planet.tileToPos(Vector2(tilex,tiley))
	planet.entityContainer.add_child(ins)

func spawnItemVelocity(pos:Vector2,id:int,planet,velocity:Vector2,amount:int=1):
	# spawns an item without considering special cases and with velocity
	var ins = groundItemScene.instantiate()
	ins.itemID = id
	ins.dropvel = velocity
	ins.amount = amount
	ins.position = pos
	ins.coolVelcoity = true
	planet.entityContainer.add_child(ins)

func spawnBreakParticle(tilex:int,tiley:int,id:int,otherId:int,planet,infoID:int,doneByPlayer:bool=false):
	
	var newId = id
	if otherId != -1:
		newId = otherId
	
	var ins = blockBreakParticle.instantiate()
	ins.textureID = newId
	ins.infoID = infoID
	ins.blockID = id
	ins.position = planet.tileToPos(Vector2(tilex,tiley))
	ins.doneByPlayer = doneByPlayer
	planet.entityContainer.add_child(ins)

## multiTile stuff
func checkIfPlaceable(tileX:int,tileY:int,planet,size:Vector2i,grounded:bool,startInfo:int,blockIgnore:int):
	
	var mltY = startInfo / size.x
	var mltX = (size.x * mltY * -1) + startInfo
	var dir = planet.DATAC.getPositionLookup(tileX,tileY)
	
	for xi in range(size.x):
		for yi in range(size.y + int(grounded)):
			var rot = Vector2( xi - mltX, yi - mltY ).rotated((PI/2)*dir);
			var worldX :int = tileX + round(rot.x)
			var worldY :int = tileY + round(rot.y)
			
			var tile = planet.DATAC.getTileData(worldX,worldY)
			
			if grounded && yi == size.y: # return false if not grounded
				if !BlockData.theChunker.getBlockDictionary(tile)["hasCollision"]:
					return false
			elif tile >= 2 and tile != blockIgnore: # return false if block in the way
				return false
			
			if worldX < 0 or worldX >= planet.SIZEINCHUNKS * 8:
				return false # return false if outside world boundaries
			if worldY < 0 or worldY >= planet.SIZEINCHUNKS * 8:
				return false
			
			
			var newDir = planet.DATAC.getPositionLookup(worldX,worldY)
			if newDir != dir: # return false if on world corner
				return false
		
	return true

func placeTiles(tileX:int,tileY:int,planet,size:Vector2i,blockID:int,startInfo:int,infoOffset:int):
	
	
	var DICK = {}
	
	
	var mltY = startInfo / size.x
	var mltX = (size.x * mltY * -1) + startInfo
	var dir = planet.DATAC.getPositionLookup(tileX,tileY)
	
	var i = 0
	
	for xi in range(size.x):
		for yi in range(size.y):
			var rot = Vector2( xi - mltX, yi - mltY ).rotated((PI/2)*dir);
			var worldX :int = tileX + round(rot.x)
			var worldY :int = tileY + round(rot.y)
			
			var replacePos := Vector2i( worldX,worldY )
			DICK[replacePos] = blockID;
			
			var info = (yi * size.x) + i
			
			planet.DATAC.setInfoData(worldX,worldY,info + infoOffset)
			
		i += 1
		
	return DICK

func placeDoor(tileX:int,tileY:int,planet,startInfo:int,infoOffset:int,side:int):
	
	
	var DICK = {}
	var size :Vector2i = Vector2i(2,2)
	
	var mltY = startInfo / size.x
	var mltX = (size.x * mltY * -1) + startInfo
	var dir = planet.DATAC.getPositionLookup(tileX,tileY)
	
	#var i = 0
	
	for xi in range(size.x):
		for yi in range(size.y):
			var rot = Vector2( xi - mltX, yi - mltY ).rotated((PI/2)*dir);
			var worldX :int = tileX + round(rot.x)
			var worldY :int = tileY + round(rot.y)
			
			var replacePos := Vector2i( worldX,worldY )
			if side == xi:
				DICK[replacePos] = 22;
				
				#var info = (yi * size.x) + i
				
				planet.DATAC.setInfoData(worldX,worldY,yi + infoOffset)
			else:
				DICK[replacePos] = 0;
			
		#i += 1
		
	return DICK

func spawnLooseItem(position,body,id,amount):
	
	if id == -1:
		return
	
	var ins = groundItemScene.instantiate()
	ins.itemID = id
	ins.amount = amount
	ins.position = position
	body.entityContainer.add_child(ins)

func getSoundMaterialID(blockID) -> int:
	var d = theChunker.getBlockDictionary(blockID)
	return d["soundMaterial"]

func doBlockAction(action:String,tileX:int,tileY:int,planet):
	match action:
		"drip":
			var ins = load("res://object_scenes/entity/enemy_scenes/ambientEntities/caveDrip/caveDrip.tscn").instantiate()
			ins.position = planet.tileToPos(Vector2(tileX,tileY))
			ins.planet = planet
			planet.entityContainer.add_child(ins)
		"leaf":
			var ins = load("res://object_scenes/entity/enemy_scenes/ambientEntities/leafFall/leafFall.tscn").instantiate()
			ins.position = planet.tileToPos(Vector2(tileX,tileY))
			ins.planet = planet
			planet.entityContainer.add_child(ins)
		"leafrustle":
			var p = planet.tileToPos(Vector2(tileX,tileY))
			var g = planet.to_global(p)
			SoundManager.playSound("ambient/treerustle",g,1.0,0.02)
		"sparkle":
			var ins = load("res://items/blocks/foliage/rockFoliage/sparkle_part.tscn").instantiate()
			ins.position = planet.tileToPos(Vector2(tileX,tileY))
			ins.z_index = 5
			ins.z_as_relative = false
			planet.entityContainer.add_child(ins)
		"furnacesound":
			var p = planet.tileToPos(Vector2(tileX,tileY))
			var g = planet.to_global(p)
			SoundManager.playSound("ambient/furnaceCrackle",g,1.0,0.02)
		"spark":
			var ins = load("res://items/electrical/electric_spark.tscn").instantiate()
			ins.position = planet.tileToPos(Vector2(tileX,tileY))
			ins.rotation = (PI/2) * planet.DATAC.getPositionLookup(tileX,tileY)
			ins.z_index = 5
			ins.z_as_relative = false
			planet.entityContainer.add_child(ins)
			SoundManager.playSound("blocks/zap",planet.to_global(ins.position),1.0)
		"teleport":
			var pos = planet.tileToPos(Vector2(tileX,tileY))
			var dir = planet.DATAC.getPositionLookup(tileX,tileY)
			var info = planet.DATAC.getInfoData(tileX,tileY)
			var offset = Vector2( 4,-8 )
			if info == 1:
				offset = Vector2( -4,-8 )
			
			GlobalRef.player.position = pos + offset.rotated( dir * (PI/2) )
		"forceOpen":
			GlobalRef.player.openDoor(Vector2i(tileX,tileY),planet,1)
			SoundManager.playSound("interacts/door",planet.to_global(planet.tileToPos(Vector2(tileX,tileY))),1.2,0.1)
		"forceClose":
			var info = planet.DATAC.getInfoData(tileX,tileY) % 8
			if [0,2,5,7].has(info):
				return
			GlobalRef.player.closeDoor(Vector2i(tileX,tileY),planet)
			SoundManager.playSound("interacts/door",planet.to_global(planet.tileToPos(Vector2(tileX,tileY))),1.2,0.1)
		"spitter":
			print("spitting!")
			
			var dir :Vector2i= Vector2i(Vector2(1,0).rotated( planet.DATAC.getInfoData(tileX,tileY) * (PI/2) ))
			var ins = load("res://items/electrical/spitter/spitter_block_spit.tscn").instantiate()
			ins.position = planet.tileToPos( Vector2(tileX+dir.x,tileY+dir.y) )
			ins.direction = Vector2( dir.x, dir.y )
			ins.planet = planet
			ins.blockID = planet.DATAC.getTileData( tileX+dir.x,tileY+dir.y )
			ins.info = planet.DATAC.getInfoData( tileX+dir.x,tileY+dir.y )
			planet.entityContainer.add_child( ins )
			
			print(planet.DATAC.getTileData( tileX+dir.x,tileY+dir.y ))
			
			planet.editTiles( { Vector2i(tileX+dir.x,tileY+dir.y) : 0 } )
			
func checkForEmmission(id):
	var d = theChunker.getBlockDictionary(id)
	return d["lightEmmission"]

func getLookup():
	return theChunker.returnLookup()
