extends Enemy

var state :int = 0 # 0: falling, 1: landed

var chill := 0.0

var xDir :int= 1

var rollTicks :float = 0.0

func _process(delta):
	match state:
		0:
			fall(delta)
		1:
			landed(delta)

func fall(delta):
	var vel = getVelocity()
	
	rollTicks += delta
	if rollTicks > 0.75:
		rollTicks -= 0.75
		xDir = (randi() % 3) - 1
	
	vel.y = 40
	vel.x = lerp(vel.x,xDir * 20.0,0.05)
	
	$Sprite.rotation = xDir * 0.1
	
	setVelocity(vel)
	move_and_slide()
	if isOnFloor():
		state = 1

func landed(delta):
	chill += delta
	$Sprite.scale.x -= delta * 0.5 
	$Sprite.scale.y -= delta * 0.5 
	if chill > 2.0:
		queue_free()

func isOnFloor():
	$RayCast2D.rotation = getQuad(self) * (PI/2)
	$RayCast2D.force_raycast_update()
	return $RayCast2D.is_colliding()
