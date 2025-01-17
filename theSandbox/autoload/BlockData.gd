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
	spawnGroundItem(x,y,data["itemToDrop"],planet,blockID)
	
	planet.editTiles( theChunker.runBreak(planet.DATAC,Vector2i.ZERO,x,y,blockID) )

func breakWall(x,y,planet,blockID):
	if blockID <= 1:
		return
	
	var data = theChunker.getBlockDictionary(blockID)
	spawnBreakParticle(x,y,blockID,data["breakParticleID"],planet,0,true)
	if ItemData.itemExists(-blockID):
		spawnGroundItem(x,y,-blockID,planet)


func spawnGroundItem(tilex:int,tiley:int,id:int,planet,oldBlock:int=0):
	
	## special cases ##
	match id:
		-1:
			return
		7: # is tree sapling
			
			if randi() % 30 == 0:
				spawnItemRaw(tilex,tiley,3037,planet)
			
			if oldBlock == 9:
				if randi() % 3 != 0:
					return # returns if dropped from big tree
		
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
		110:
			if oldBlock == 111:
				if randi() % 3 != 0:
					return # returns if dropped from big tree
	
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
			var dir :Vector2i= Vector2i(Vector2(1,0).rotated( planet.DATAC.getInfoData(tileX,tileY) * (PI/2) ))
			var ins = load("res://items/electrical/spitter/spitter_block_spit.tscn").instantiate()
			ins.position = planet.tileToPos( Vector2(tileX+dir.x,tileY+dir.y) )
			ins.direction = Vector2( dir.x, dir.y )
			ins.planet = planet
			ins.ogTile = Vector2( tileX+dir.x,tileY+dir.y )
			ins.blockID = planet.DATAC.getTileData( tileX+dir.x,tileY+dir.y )
			ins.info = planet.DATAC.getInfoData( tileX+dir.x,tileY+dir.y )
			planet.entityContainer.add_child( ins )
			planet.editTiles( { Vector2i(tileX+dir.x,tileY+dir.y) : 0 } )
		"placer":
			# if this is being ran, chest and empty space are already confirmed
			var chestPos :Vector2i= Vector2i(tileX,tileY)+Vector2i(Vector2(-1,0).rotated( planet.DATAC.getInfoData(tileX,tileY) * (PI/2) ))
			if planet.chestDictionary.has(Vector2(chestPos)):
				var chestString = planet.chestDictionary[Vector2(chestPos)]
				var chestData = PlayerData.loadChestString(chestString)
				
				if PlayerData.currentSelectedChest == Vector2(chestPos):
					PlayerData.closeChest()
				
				var slot = -1
				var type = 0
				for i in range(25):
					var id = chestData[i][0]
					var data = ItemData.getItem(id)
					if data is ItemBlock:
						slot = i
						break
					if data is ItemPlant:
						slot = i
						type = 1
						break
					if data is ItemTypeBlock:
						slot = i
						type = 2
						break
				if slot == -1:
					var p = planet.to_global( planet.tileToPos( Vector2(chestPos.x,chestPos.y) ) )
					SoundManager.playSound("blocks/placer",p,1.0,0.1)
					return
				
				var itemID = chestData[slot][0]
				var amount = chestData[slot][1]
				
				if amount > 1:
					chestData[slot] = [itemID,amount-1]
				else:
					chestData[slot] = [-1,-1] # delete item if only 1 left
				
				var newString = PlayerData.saveChestFromArray(chestData)
				planet.chestDictionary[Vector2(chestPos)] = newString
				
				var placePos :Vector2i= Vector2i(tileX,tileY)+Vector2i(Vector2(1,0).rotated( planet.DATAC.getInfoData(tileX,tileY) * (PI/2) ))
				
				var blockID = 2
				var data = ItemData.getItem(itemID)
				match type:
					0:
						blockID = data.blockID
					1:
						blockID = data.blockToPlace
					2:
						blockID = data.blockID
						planet.DATAC.setInfoData(placePos.x,placePos.y,data.multiTileId)
				
				planet.editTiles( {placePos: blockID},true )
				
				var s = SoundManager.getMineSound(blockID)
				var p = planet.to_global( planet.tileToPos( Vector2(placePos.x,placePos.y) ) )
				SoundManager.playSoundStream( s,p, SoundManager.blockPlaceVol, 0.1,"BLOCKS")

				
			else:
				var p = planet.to_global( planet.tileToPos( Vector2(chestPos.x,chestPos.y) ) )
				SoundManager.playSound("blocks/placer",p,1.0,0.1)
		
		"hopper":
			
			var dir :int= planet.DATAC.getPositionLookup(tileX,tileY)
			var chestPos = Vector2(0,1).rotated( (PI/2) * dir ) + Vector2(tileX,tileY)
			
			var ins = load("res://items/electrical/hopper/hoppe_item_detector.tscn").instantiate()
			ins.position = planet.tileToPos(Vector2(tileX,tileY))
			ins.planet = planet
			ins.chestPos = chestPos
			ins.rotation = (PI/2) * dir
			planet.entityContainer.add_child(ins)
		"trapdoorOpen":
			var dick = GlobalRef.player.setAllTrapdoors(Vector2(tileX,tileY),48,planet)
			planet.editTiles( dick )
			var p = planet.to_global( planet.tileToPos(Vector2(tileX,tileY) ) )
			SoundManager.playSound("interacts/door",p,1.2,0.1)
		"trapdoorClose":
			var dick = GlobalRef.player.setAllTrapdoors(Vector2(tileX,tileY),47,planet)
			planet.editTiles( dick )
			var p = planet.to_global( planet.tileToPos(Vector2(tileX,tileY) ) )
			SoundManager.playSound("interacts/door",p,1.2,0.1)
		"windchime":
			var p = planet.tileToPos(Vector2(tileX,tileY))
			var g = planet.to_global(p)
			SoundManager.playSound("ambient/windchime",g,0.8,0.1)

func checkForEmmission(id):
	var d = theChunker.getBlockDictionary(id)
	return d["lightEmmission"]

func getLookup():
	return theChunker.returnLookup()
