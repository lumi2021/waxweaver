extends Item
class_name ItemBonemeal

@export var strength :int = 1000

func onUse(tileX:int,tileY:int,planetDir:int,planet,lastTile:Vector2):
	
	if planet.tileToPos( Vector2(tileX,tileY) ) == null:
		return
	
	if planet.DATAC.getTileData(tileX,tileY) < 2:
		return # dont allow player to age air
	
	var time = planet.DATAC.getTimeData(tileX,tileY)
	planet.DATAC.setTimeData(tileX,tileY, time - strength )
	
	# put effect here
	var ins = load("res://items/material/bonemeal/bonemealparticle.tscn").instantiate()
	GlobalRef.player.get_parent().add_child(ins)
	ins.position = planet.tileToPos( Vector2(tileX,tileY) )
	ins.rotation = planetDir * (PI/2)
	PlayerData.consumeSelected()
