extends Enemy

var delayTickX = 0
var poop = 0

func _ready():
	$axis/AnimatedSprite2D.play("default")

func _physics_process(delta):
	
	$axis.rotation = getQuad(self) * (PI/2)
	
	var targetY = getVERTICALDirectionTowardsPlayer()
	var targetX = getDirectionTowardsPlayer()
	
	$axis/wallscanner.target_position.x = 5 * targetX
	$axis/wallscanner.force_raycast_update()
	
	#if delayTickY <= 0:
	#	if $axis/floorScanner.is_colliding():
	#		delayTickY = 10
	#if delayTickY > 0:
	#	delayTickY -= 1
	#	targetY *= -1
	
	if delayTickX <= 0:
		if $axis/wallscanner.is_colliding():
			delayTickX = 30
	if delayTickX > 0:
		delayTickX -= 1
		targetX *= -1
		targetY = (((randi() % 2) * 2) - 1) * 6.0
	
	if GlobalRef.player.dead:
		targetY = -4.0
	if getSurface() < 0.0 and !GlobalRef.isNight():
		targetY = -4.0
	
	
	var vel = getVelocity()
	
	var speed = 200.0 - (getPlayerDistance()*0.75)
	
	vel.x = lerp( vel.x,targetX* speed, 0.02)
	vel.y = lerp( vel.y,targetY* 120.0, 0.02)
	
	setVelocity(vel)
	
	move_and_slide()
	
	$axis/AnimatedSprite2D.flip_h = vel.x > 0.0
	$axis/AnimatedSprite2D.rotation = vel.y * 0.01 * ((int( vel.x > 0.0 )*2)-1)
