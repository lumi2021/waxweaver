extends Item
class_name ItemBlock

@export var blockID := 0


func onUse(tileX:int,tileY:int,planetDir:int,planet,lastTile:Vector2):
	
	if planet == null:
		#Cancel if not on planet
		return "failure"
	
	var block = planet.DATAC.getTileData(tileX,tileY)
	var bg = planet.DATAC.getBGData(tileX,tileY)
	
	if ![0,1].has(block):
		#Cancel is target tile isn't empty
		return "failure"
	
	if ![0,1].has(bg):
		#Succeed if wall tile exists
		var edit = Vector2i(tileX,tileY)
		planet.editTiles({edit:blockID})
		PlayerData.consumeSelected()
		return "success"
	
	for i in range(4):
		#Search neighboring tiles
		var s = Vector2(1,0).rotated((PI/2)*i)
		var tile = Vector2(tileX,tileY) + Vector2(int(s.x),int(s.y))
		if tile.x < 0 or tile.x >= planet.SIZEINCHUNKS * 8 or tile.y < 0 or tile.y >= planet.SIZEINCHUNKS * 8:
			continue
		
		if ![0,1].has(planet.DATAC.getTileData(tile.x,tile.y)):
			var edit = Vector2i(tileX,tileY)
			planet.editTiles({edit:blockID})
			PlayerData.consumeSelected()
			return "success"
	
	return "failure"
