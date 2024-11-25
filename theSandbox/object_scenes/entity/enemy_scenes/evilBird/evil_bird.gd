extends Enemy

var delayTickX = 0
var poop = 0

var searchTicks :int= 0
var playerSpotted :bool= false

func _ready():
	#$axis/AnimatedSprite2D.play("default")
	pass

func _physics_process(delta):
	if playerSpotted:
		chase(delta)
	else:
		waitForPlayer(delta)

func chase(delta):
	
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
	if getWater() > 0.5:
		targetY = -2.0 # bird will not be able to enter water
		targetX *= -1.0
	
	var vel = getVelocity()
	
	var speed = 200.0 - (getPlayerDistance()*0.75)
	
	vel.x = lerp( vel.x,targetX* speed, 0.02)
	vel.y = lerp( vel.y,targetY* 120.0, 0.02)
	
	setVelocity(vel)
	
	move_and_slide()
	
	$axis/AnimatedSprite2D.flip_h = vel.x > 0.0
	$axis/AnimatedSprite2D.rotation = vel.y * 0.01 * ((int( vel.x > 0.0 )*2)-1)

func waitForPlayer(delta):
	var vel = getVelocity()
	vel.y += 1000 * delta
	var dir = ((randi()%2)*2)-1 # either -1 or 1
	if randi() % 100 == 0:
		vel = Vector2(dir*100,-100)
		$axis/AnimatedSprite2D.flip_h = dir > 0
		SoundManager.playSound("enemy/step",global_position,0.8,0.1)
	
	$axis.rotation = getWorldRot(self)
	
	if $axis/floorScanner.is_colliding():
		vel.x = lerp(vel.x,0.0,0.2)
	
	setVelocity(vel)
	move_and_slide()
	
	$pointAtPlayer.target_position = to_local(GlobalRef.player.global_position)
	if !$pointAtPlayer.is_colliding():
		searchTicks += 1
		if searchTicks > 10:
			playerSpotted = true
			$axis/AnimatedSprite2D.play("default")
