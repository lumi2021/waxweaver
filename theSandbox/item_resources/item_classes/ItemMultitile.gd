extends Item
class_name ItemMultitile

@export var blockID := 0

@export var size :Vector2=Vector2(3,2)

@export var grounded :bool = false
@export var needsWalls :bool = false


func onUse(tileX:int,tileY:int,planetDir:int,planet,lastTile:Vector2):
	
	if planet == null:
		#Cancel if not on planet
		return "failure"
	
	var o = planet.DATAC.getPositionLookup(tileX,tileY)
	var d = size.rotated(o*(PI/2))
	if checkAvailableArea(tileX,tileY,d,planet,o):
		planet.editTiles(makeCoolEditArray(tileX,tileY,d,planet,o%2==0))
	
# returns whether or not block can be placed
func checkAvailableArea(startX,startY,dimensions:Vector2,planet,originalDir):
	
	if grounded:
		var find = Vector2( startX , startY)
		for i in range(size.x):
			var rot = find + Vector2( i, size.y ).rotated(originalDir*(PI/2))
			var worldPos = Vector2i( rot.x, rot.y)
			var block = planet.DATAC.getTileData(worldPos.x,worldPos.y)
			if [0,1].has(block):
				return false
	
	
	for x in range( round( abs(dimensions.x) ) ):
		for y in range( round( abs(dimensions.y) ) ):
			var worldPos = Vector2i( startX+x, startY+y)
			#account for negative dimensions
			if dimensions.x < 0:
				worldPos.x = startX-x
			if dimensions.y < 0:
				worldPos.y = startY-y
			
			var block = planet.DATAC.getTileData(worldPos.x,worldPos.y)
			var curDir = planet.DATAC.getPositionLookup(worldPos.x,worldPos.y)
			#var bg = planet.DATAC.getBGData(tileX,tileY)
			if curDir != originalDir:
				# invalid if on corner of world
				return false
			if ![0,1].has(block):
				# invalid if solid tile exists
				return false
			
			if worldPos.x < 0 or worldPos.x >= planet.SIZEINCHUNKS * 8 or worldPos.y < 0 or worldPos.y >= planet.SIZEINCHUNKS * 8:
				# invalid if any tile is outside boundaries
				return false
			
	return true

func makeCoolEditArray(startX,startY,dimensions:Vector2,planet,epicRotate):
	
	var DICK = {}
	var i = 0
	
	print("\n")
	
	print(dimensions)
	print(round(abs(dimensions.x)))
	
	for x in range( round( abs(dimensions.x) ) ):
		if epicRotate and i > 0:
			i -= int(size.y) + int(size.x)
		
		for y in range( round( abs(dimensions.y) ) ):
			var worldPos = Vector2i( startX+x, startY+y)
			#account for negative dimensions
			if dimensions.x < 0:
				worldPos.x = startX-x
			if dimensions.y < 0:
				worldPos.y = startY-y
				
			DICK[worldPos] = blockID
			print(i)
			planet.DATAC.setInfoData(worldPos.x,worldPos.y,i)
			if !epicRotate:
				i += 1
			else:
				i += int(size.x)
			
	
	print("\n")
	
	return DICK
