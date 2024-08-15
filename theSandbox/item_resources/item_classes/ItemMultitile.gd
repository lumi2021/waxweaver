extends Item
class_name ItemMultitile

@export var blockID := 0

@export var size :Vector2i=Vector2i(3,2)

@export var grounded :bool = false
@export var needsWalls :bool = false


func onUse(tileX:int,tileY:int,planetDir:int,planet,lastTile:Vector2):
	
	if planet == null:
		#Cancel if not on planet
		return "failure"
	
	if checkIfPlaceable(tileX,tileY,planet):
		PlayerData.consumeSelected()
		planet.editTiles( placeTiles(tileX,tileY,planet) )


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
			
			planet.DATAC.setInfoData(worldX,worldY,info)
			
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
			elif tile >= 2: # return false if block in the way
				return false
			
			if needsWalls:
				var BG = planet.DATAC.getBGData(worldX,worldY)
				if BG < 2:
					return false
			
			if worldX < 0 or worldX >= planet.SIZEINCHUNKS * 8:
				return false # return false if outside world boundaries
			if worldY < 0 or worldY >= planet.SIZEINCHUNKS * 8:
				return false
			
			
			var newDir = planet.DATAC.getPositionLookup(worldX,worldY)
			if newDir != dir: # return false if on world corner
				return false
		
	return true
