extends Item
class_name ItemDoor

@export var blockID := 0

@export var size :Vector2i=Vector2i(1,2)

var grounded :bool = true

@export var doorType :int = 0


var replaceableBlocks :Array[int] = [0,1,17,77,82,90,131]

func onUse(tileX:int,tileY:int,planetDir:int,planet,lastTile:Vector2):
	
	if planet == null:
		#Cancel if not on planet
		return "failure"
	
	if checkIfPlaceable(tileX,tileY,planet):
		PlayerData.consumeSelected()
		playSound(tileX,tileY,planet)
		planet.editTiles( placeTiles(tileX,tileY,planet),true )


func placeTiles(tileX:int,tileY:int,planet):
	
	
	var DICK = {}
	
	var startInfo = (size.x * size.y) - size.x
	
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
			
			planet.DATAC.setInfoData(worldX,worldY,info + (doorType * 2))
			
		i += 1
		
	return DICK

func checkIfPlaceable(tileX:int,tileY:int,planet):
	
	var startInfo = (size.x * size.y) - size.x
	
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
			elif !replaceableBlocks.has(tile): # return false if block in the way
				return false
			
			if worldX < 0 or worldX >= planet.SIZEINCHUNKS * 8:
				return false # return false if outside world boundaries
			if worldY < 0 or worldY >= planet.SIZEINCHUNKS * 8:
				return false
			
			
			var newDir = planet.DATAC.getPositionLookup(worldX,worldY)
			if newDir != dir: # return false if on world corner
				return false
		
	return true

func playSound(tileX:int,tileY:int,planet):
	var s = SoundManager.getMineSound(abs(blockID))
	var p = GlobalRef.player.global_position
	SoundManager.playSoundStream( s,p, SoundManager.blockPlaceVol, 0.1,"BLOCKS" )
