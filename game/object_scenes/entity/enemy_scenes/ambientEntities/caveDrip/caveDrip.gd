extends Enemy

var state :int = 0 # 0: idle, 1: falling, 2: landed

func _process(delta):
	match state:
		0:
			idle(delta)
		1:
			fall(delta)
		2:
			landed(delta)

func idle(delta):
	var s = $Sprite.scale.x
	s += 0.01
	$Sprite.scale = Vector2(s,s)
	if s >= 1.0:
		state = 1

func fall(delta):
	var vel = getVelocity()
	vel.y += 1000 * delta
	setVelocity(vel)
	move_and_slide()
	if isOnFloor():
		state = 2

func landed(delta):
	var r = str( (randi()%2) + 1 )
	SoundManager.playSound("blocks/caveDrip" + r,global_position,1.0,0.1)
	
	queue_free()

func isOnFloor():
	$RayCast2D.rotation = getQuad(self) * (PI/2)
	$RayCast2D.force_raycast_update()
	return $RayCast2D.is_colliding()
