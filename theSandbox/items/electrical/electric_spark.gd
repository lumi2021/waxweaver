extends CPUParticles2D

var tick :int= 0
func _ready():
	emitting = true

func _on_finished():
	queue_free()
