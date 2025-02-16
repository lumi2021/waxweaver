extends Node2D

var old :int = 0

func _ready():
	$CPUParticles2D.emitting = true
	SoundManager.playSound("items/lightning",global_position,0.75,0.02)

func _process(delta):
	old += 1
	if old == 3:
		$Hurtbox.queue_free()
		$Hurtbox2.queue_free()
	if old > 60:
		queue_free()
