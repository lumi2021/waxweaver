extends CPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready():
	emitting = true
	SoundManager.playSound("items/giftUse",global_position,1.5,0.05)


func _on_finished():
	queue_free()
