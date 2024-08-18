extends CPUParticles2D

var effectName = ""
var hc :HealthComponent

func _process(delta):
	global_position = hc.get_parent().global_position
	
