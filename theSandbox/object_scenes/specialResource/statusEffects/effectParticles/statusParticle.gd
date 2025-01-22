extends CPUParticles2D

var effectName = ""
var hc :HealthComponent

#func _ready():
	#local_coords = true

func _process(delta):
	global_position = hc.get_parent().global_position
	
	var p = GlobalRef.currentPlanet
	var pos = p.posToTile(p.to_local(global_position))
	var dir = p.DATAC.getPositionLookup(pos.x,pos.y)
	rotation = (PI/2) * dir
	print(rotation)
