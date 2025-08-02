extends Enemy

var wanderTicks :int = 0
var wanderDir :int= 0
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	wanderTicks += 1
	if wanderTicks > 120:
		wanderDir = (randi() % 3) - 1
		wanderTicks = 0
		if wanderDir == -1:
			$axis/Snail.flip_h = true
		elif wanderDir == 1:
			$axis/Snail.flip_h = false
	
	
	var vel :Vector2 = getVelocity()
	vel.x = wanderDir * 20
	vel.y += 1000 * delta
	setVelocity(vel)
	
	move_and_slide()
	
	$axis.rotation = getWorldRot(self)
