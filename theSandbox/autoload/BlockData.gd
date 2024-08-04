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
	
	theChunker.attemptSpawnEnemy.connect(attemptSpawnEnemy)

func attemptSpawnEnemy(planet,tile:Vector2,blockID:int,dir:int):
	CreatureData.attemptSpawnEnemy(planet,tile,blockID,dir)

func breakBlock(x,y,planet,blockID):
	
	var data = theChunker.getBlockDictionary(blockID)
	
	spawnBreakParticle(x,y,blockID,data["breakParticleID"],planet)
	spawnGroundItem(x,y,data["itemToDrop"],planet)
	
	planet.editTiles( theChunker.runBreak(planet.DATAC,Vector2i.ZERO,x,y,blockID) )

func breakWall(x,y,planet,blockID):
	
	
	if blockID <= 1:
		return
	
	var data = theChunker.getBlockDictionary(blockID)
	spawnBreakParticle(x,y,blockID,data["breakParticleID"],planet)
	if ItemData.itemExists(-blockID):
		spawnGroundItem(x,y,-blockID,planet)


func spawnGroundItem(tilex:int,tiley:int,id:int,planet):
	
	## special cases ##
	match id:
		-1:
			return
		19: # is chair
			id = 6000 + ( planet.DATAC.getInfoData(tilex,tiley) / 4)
		22: # is closed door
			id = 6050 + ( planet.DATAC.getInfoDadta(tilex,tiley) / 2)
		23: # is open door
			id = 6050 + ( planet.DATAC.getInfoData(tilex,tiley) / 8)
	
	
	var ins = groundItemScene.instantiate()
	ins.itemID = id
	ins.position = planet.tileToPos(Vector2(tilex,tiley))
	planet.entityContainer.add_child(ins)

func spawnBreakParticle(tilex:int,tiley:int,id:int,otherId:int,planet):
	
	var newId = id
	if otherId != -1:
		newId = otherId
	
	var ins = blockBreakParticle.instantiate()
	ins.textureID = newId
	ins.position = planet.tileToPos(Vector2(tilex,tiley))
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
	
	var i = 0
	
	for xi in range(size.x):
		for yi in range(size.y):
			var rot = Vector2( xi - mltX, yi - mltY ).rotated((PI/2)*dir);
			var worldX :int = tileX + round(rot.x)
			var worldY :int = tileY + round(rot.y)
			
			var replacePos := Vector2i( worldX,worldY )
			if side == xi:
				DICK[replacePos] = 22;
				
				var info = (yi * size.x) + i
				
				planet.DATAC.setInfoData(worldX,worldY,yi + infoOffset)
			else:
				DICK[replacePos] = 0;
			
		i += 1
		
	return DICK

func spawnLooseItem(position,body,id,amount):
	
	if id == -1:
		return
	
	var ins = groundItemScene.instantiate()
	ins.itemID = id
	ins.amount = amount
	ins.position = position
	body.entityContainer.add_child(ins)
