extends Item
class_name ItemMirror

func onUse(tileX:int,tileY:int,planetDir:int,planet,lastTile:Vector2):
	
	var hc :HealthComponent = GlobalRef.player.healthComponent
	
	if !hc.checkIfHasEffect("teleportsickness"):
		GlobalRef.player.respawn()
		hc.inflictStatus("teleportsickness",4.0)
