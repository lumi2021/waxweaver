extends Enemy

var state :int = 0 # 0 = idle, 1 = hunt, 2 = dash, 3 = swimming

@onready var rotAxis = $axis
@onready var floorRay = $axis/floorRay
@onready var wallRay = $axis/wallRay
@onready var playerPointer = $playerPointer
@onready var diggingDetectRay = $axis/diggingdetect
@onready var sprite = $axis/Sprite
@onready var particle = $part

var wanderDir :int= 0

var sightLostWhileHunting :int = 0

var dashTicks :int = 0
var blockInside :int= 3

var tick :int = 0

func _physics_process(delta):
	tick += 1
	match state:
		0:
			wander(delta)
		1:
			hunt(delta)
		2:
			dash(delta)
		3:
			swimming(delta)

func wander(delta):
	var vel = getVelocity()
	
	if randi() % 100 == 0:
		wanderDir = (randi() % 3) -1
	
	rotAxis.rotation = lerp_angle(rotAxis.rotation,getWorldRot(self),0.2)
	
	if floorRay.is_colliding():
		vel.x = lerp(vel.x, wanderDir * 15.0, 0.05 )
	else:
		vel.x = vel.x + (wanderDir * 1) * 60 * delta
	
	vel.y += 1000 * delta
	
	wallRay.target_position.x = 6 * wanderDir
	wallRay.force_raycast_update()
	if wallRay.is_colliding() and floorRay.is_colliding():
		vel.y = -220
	
	if getWater() > 0.5:
		vel.y -= 25.0 * 60 * delta
	
	setVelocity(vel)
	
	move_and_slide()
	
	playerPointer.target_position = to_local(GlobalRef.player.global_position)
	if !playerPointer.is_colliding(): # line of sight made
		state = 1
	
	if wanderDir == 1:
		sprite.flip_h = true
	elif wanderDir == -1:
		sprite.flip_h = false
	
	animation(wanderDir != 0)

func hunt(delta):
	var vel = getVelocity()
	
	var dir = getDirectionTowardsPlayer()
	
	if GlobalRef.player.dead:
		dir *= -1
	
	rotAxis.rotation = lerp_angle(rotAxis.rotation,getWorldRot(self),0.2)
	
	if floorRay.is_colliding():
		vel.x = lerp(vel.x, dir * 40.0, 0.05 )
	else:
		vel.x = vel.x + (dir * 0.5) * 60 * delta
	
	vel.y += 1000 * delta
	
	wallRay.target_position.x = 6 * dir
	wallRay.force_raycast_update()
	if wallRay.is_colliding() and floorRay.is_colliding():
		vel.y = -220
	
	if getPlayerDistance() < 32 and floorRay.is_colliding():
		vel.y = -150
		vel.x = dir * 60
	
	if randi() % 100 == 0 and floorRay.is_colliding():
		vel.y = -150
		vel.x = dir * 60
		
	if getWater() > 0.5:
		vel.y -= 25.0 * 60 * delta
	
	setVelocity(vel)
	
	move_and_slide()
	
	if dir == 1:
		sprite.flip_h = true
	elif dir == -1:
		sprite.flip_h = false
	
	animation(true)
	
	$diggin.playing = false
	
	#continue to scan for line of sight
	playerPointer.target_position = to_local(GlobalRef.player.global_position)
	if playerPointer.is_colliding(): # player isn't seen
		sightLostWhileHunting += 1
	else:
		sightLostWhileHunting = 0 # reset counter if player is seen again
	
	if sightLostWhileHunting > 60: # if player isnt seen for 1 second
		
		$CollisionShape2D.call_deferred("set_disabled",true) # disable collision
		velocity = to_local(GlobalRef.player.global_position).normalized() * 200
		state = 2 # enter dash state
		sprite.z_index = -2
		sprite.frame = 0
		sightLostWhileHunting = 0

func dash(delta):
	dashTicks += 1
	rotAxis.rotation = velocity.angle() + (PI/2)
	move_and_slide()
	sprite.flip_h = !sprite.flip_h
	if diggingDetectRay.is_colliding(): # entered terrain, start digging
		state = 3
		$diggin.play()
		particle.emitting = true
		velocity = velocity.normalized() * 140.0
		dashTicks = 0
	if dashTicks > 40: # 1put him back into hunt state if dashing for too long
		$CollisionShape2D.call_deferred("set_disabled",false) # reenable collision
		state = 1
		dashTicks = 0
		sprite.z_index = 0

func swimming(delta):
	
	var tileInside :int = getTile()
	if tileInside != blockInside:
		blockInside = tileInside
		var img :Image= BlockData.getBlockTexture(blockInside).get_image()
		img.crop(8,8)
		var tex :ImageTexture = ImageTexture.create_from_image(img)
		particle.texture = tex
	
	var dir = to_local(GlobalRef.player.global_position).normalized()
	
	sprite.flip_h = !sprite.flip_h
	velocity = lerp(velocity,dir * 100,0.05)
	rotAxis.rotation = velocity.angle() + (PI/2)
	move_and_slide()
	
	if !diggingDetectRay.is_colliding(): # exited terrain
		$CollisionShape2D.call_deferred("set_disabled",false) # reenable collision
		state = 1 # back to hunt state
		$diggin.stream_paused = true
		sprite.z_index = 0
		particle.emitting = false

func animation(moving:bool):
	if moving:
		if tick % 5 == 0:
			sprite.frame = (sprite.frame + 1) % 4
	else:
		sprite.frame = 0
