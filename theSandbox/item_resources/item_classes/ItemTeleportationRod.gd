extends ItemStaff
class_name ItemTeleportationRod

@export var penis :bool = false

func onUse(tileX:int,tileY:int,planetDir:int,planet,lastTile:Vector2):
	
	var hc :HealthComponent = GlobalRef.player.healthComponent
	
	var tile = planet.DATAC.getTileData(tileX,tileY)
	if BlockData.checkForCollision(tile):
		return # return if trying to teleport into solid wall
	
	GlobalRef.player.position = planet.tileToPos( Vector2(tileX,tileY) )
		
	if !hc.checkIfHasEffect("teleportsickness"):
		hc.inflictStatus("teleportsickness",4.0)
	else:
		hc.damage(30)
		hc.inflictStatus("teleportsickness",4.0)
	
	GlobalRef.player.teleport()
