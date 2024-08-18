extends StatusEffect
class_name StatusLight

@export var lightAmount :float = 0.6

func onFrame(delta):
	var body = healthComponent.getWorld()
	var tile = body.posToTile( healthComponent.parent.position )
	var l = body.DATAC.getLightData(tile.x,tile.y)
	if l <= lightAmount:
		body.DATAC.setLightData(tile.x,tile.y,-lightAmount)
