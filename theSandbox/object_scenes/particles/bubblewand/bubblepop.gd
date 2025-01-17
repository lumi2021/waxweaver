extends CPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready():
	emitting = true
	SoundManager.playSound("items/bubblepop",global_position,1.0,0.1)

func _on_finished():
	queue_free()
