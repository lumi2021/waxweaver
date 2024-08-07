extends Enemy

@export var HC : HealthComponent
@export var rotationOrigin : Node2D
@export var sprite:Sprite2D
@export var wallWay :RayCast2D
@export var floorRay :RayCast2D

var state = 0 # 0 = passive, 1 = hunting, 2 = stunned

var wanderDir = 0
var animTick = 0

func _ready():
	HC.connect("smacked",smack)

func _process(delta):
	match state:
		0:
			wander(delta)
		1:
			hunt(delta)
		2:
			stunned(delta)

func hunt(delta):
	var vel = getVelocity()
	
	var dir = getDirectionTowardsPlayer()
	
	rotationOrigin.rotation = getQuad(self) * (PI/2)
	
	if floorRay.is_colliding():
		vel.x = lerp(vel.x, dir * 50.0, 0.05 )
	else:
		vel.x = vel.x + (dir * 0.5)
	
	vel.y += 1000 * delta
	
	wallWay.target_position.x = 8 * dir
	wallWay.force_raycast_update()
	if wallWay.is_colliding() and floorRay.is_colliding():
		vel.y = -220
	
	if getPlayerDistance() < 32 and floorRay.is_colliding():
		vel.y = -150
		vel.x = dir * 60
	
	if randi() % 100 == 0 and floorRay.is_colliding():
		vel.y = -150
		vel.x = dir * 60
	
	setVelocity(vel)
	
	move_and_slide()
	
	animation(dir)

func smack():
	state = 2

func stunned(delta):
	var vel = getVelocity()
	vel.y += 1000 * delta
	
	if floorRay.is_colliding():
		vel.x = lerp(vel.x,0.0,0.08)
	
	setVelocity(vel)
	
	move_and_slide()
	
	animation(0)
	
	if abs(vel.x) < 10:
		state = 1

func wander(delta):
	var vel = getVelocity()
	
	if randi() % 100 == 0:
		wanderDir = (randi() % 3) -1
	
	rotationOrigin.rotation = getQuad(self) * (PI/2)
	
	if floorRay.is_colliding():
		vel.x = lerp(vel.x, wanderDir * 15.0, 0.05 )
	else:
		vel.x = vel.x + (wanderDir * 1)
	
	vel.y += 1000 * delta
	
	wallWay.target_position.x = 8 * wanderDir
	wallWay.force_raycast_update()
	if wallWay.is_colliding() and floorRay.is_colliding():
		vel.y = -220
	
	if getPlayerDistance() < 36:
		state = 1
	
	setVelocity(vel)
	
	move_and_slide()
	
	animation(wanderDir)

func animation(dir):
	
	if dir != 0:
		sprite.flip_h = dir == -1
		
		match animTick:
			0:
				sprite.frame = 1
			8:
				sprite.frame = 0
			16:
				sprite.frame = 2
			24:
				sprite.frame = 0
			32:
				sprite.frame = 1
				animTick = -1
		
		animTick += 1
		
	else:
		sprite.frame = 0
		animTick = 0
	
	if !floorRay.is_colliding():
		sprite.frame = 3
		return
