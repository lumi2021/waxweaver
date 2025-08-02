extends Node2D

var tick :float = 0.0
var radius :int = 3

func _ready():
	$CPUParticles2D.emitting = true
	SoundManager.playSound("items/boom",global_position,1.0,0.1)
	$Hurtbox2/CollisionShape2D.shape.radius = (radius * 8) + 4
	await get_tree().create_timer(0.2).timeout
	$Hurtbox2.queue_free()
	$Hurtbox.queue_free()
	
func _process(delta):
	tick += delta
	if tick >= 1.2:
		queue_free()
