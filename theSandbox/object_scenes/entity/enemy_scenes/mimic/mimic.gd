extends Enemy

var state :int= 0

var chargeDir :Vector2 = Vector2(1,0)
var chargeDelay :int = 0
var chargingTicks :int = 0

func _process(delta):
	match state:
		0:
			chill(delta)
		1:
			if !$axis/sprite.is_playing():
				state = 2
				$axis/sprite.play("run")
		2:
			hunt(delta)
		3:
			charge(delta)
	
	rotAxis()
	
func chill(delta):
	var vel = getVelocity()
	vel.y += 1000 * delta
	
	setVelocity(vel)
	move_and_slide()
	
	var p = to_local( GlobalRef.player.global_position )
	$playerFinder.target_position = p
	if !$playerFinder.is_colliding():
		if p.length() < 60:
			state = 1
			$axis/sprite.play("popout")

func hunt(delta):
	var vel = getVelocity()
	
	var dir = getDirectionTowardsPlayer()
	var p = to_local( GlobalRef.player.global_position )
	if $axis/wall.is_colliding():
		if p.length() < 128:
			vel.y = -60
		else:
			vel.y += 1000 * delta
	else:
		vel.y += 1000 * delta
	
		if $axis/floorCast.is_colliding():
			vel.y = -300
	
	vel.x = lerp(vel.x,200.0*dir,0.01)
	
	$axis/sprite.flip_h = vel.x < -1.0
	$axis/wall.target_position.x = ((int(!$axis/sprite.flip_h)*2) - 1) * 5
	
	chargeDelay += 1
	$playerFinder.target_position = p
	if !$playerFinder.is_colliding():
		if p.length() < 60:
			if chargeDelay > 120:
				state = 3
				chargeDelay = 0
				chargingTicks = 0
	
	setVelocity(vel)
	move_and_slide()

func charge(delta):
	chargingTicks += 1
	velocity = chargeDir * 200
	move_and_slide()
	
	if chargingTicks > 120:
		state = 2

func rotAxis():
	$axis.rotation = getWorldRot(self)
