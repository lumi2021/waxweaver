extends Item
class_name ItemWall

@export var blockID := 0


func onUse(tileX:int,tileY:int,planetDir:int,planet:Planet,lastTile:Vector2):
	
	if planet == null:
		#Cancel if not on planet
		return "failure"
	
	var arrayPosition = (tileX * planet.SIZEINCHUNKS * 8) + tileY
	
	var block = planet.DATAC.getTileData(tileX,tileY)
	var bg = planet.DATAC.getBGData(tileX,tileY)
	
	if block > 1 and bg < 2:
		#Succeed if block tile exists
		var edit = Vector3(tileX,tileY,0)
		planet.editTiles({edit:blockID})
		PlayerData.consumeSelected()
		return "success"
	
	if bg > 1:
		#fail if wall tile exists
		return "failure"
	else:
	
	
		for i in range(4):
			#Search neighboring tiles
			var s = Vector2(1,0).rotated((PI/2)*i)
			var tile = Vector2(tileX,tileY) + Vector2(int(s.x),int(s.y))
			if tile.x < 0 or tile.x >= planet.SIZEINCHUNKS * 8 or tile.y < 0 or tile.y >= planet.SIZEINCHUNKS * 8:
				continue
			
			if planet.DATAC.getBGData(tile.x,tile.y) > 1:
				var edit = Vector3(tileX,tileY,0)
				planet.editTiles({edit:blockID})
				PlayerData.consumeSelected()
				return "success"
	
	return "failure"
