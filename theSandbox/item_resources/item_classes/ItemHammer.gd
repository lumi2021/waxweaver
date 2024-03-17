extends Item
class_name ItemHammer

func onUse(tileX:int,tileY:int,planetDir:int,planet,lastTile:Vector2):
	
	if lastTile == Vector2(tileX,tileY):
		return
	
	planet.editTiles( {Vector2i(tileX,tileY) : -99999} )
