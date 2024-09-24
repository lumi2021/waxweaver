extends Enemy

@export var HC : HealthComponent
@export var rotationOrigin : Node2D
@export var sprite:Sprite2D
@export var wallWay :RayCast2D
@export var floorRay :RayCast2D

var state = 1 # 0 = passive, 1 = hunting, 2 = stunned

var wanderDir = 0
var animTick = 0
var floatamount = 25.0

@export var walkSpeed :float= 50.0

func _ready():
	HC.connect("smacked",smack)

func _physics_process(delta):
	match state:
		1:
			hunt(delta)
		2:
			stunned(delta)

func hunt(delta):
	var vel = getVelocity()
	
	var dir = getDirectionTowardsPlayer()
	
	if GlobalRef.player.dead:
		dir *= -1
	
	rotationOrigin.rotation = getQuad(self) * (PI/2)
	
	if floorRay.is_colliding():
		vel.x = lerp(vel.x, dir * walkSpeed, 0.05 )
	else:
		vel.x = vel.x + (dir * 0.5) * 60 * delta
	
	vel.y += 1000 * delta
	
	wallWay.target_position.x = 8 * dir
	wallWay.force_raycast_update()
	if wallWay.is_colliding() and floorRay.is_colliding():
		vel.y = -220
	
	if getPlayerDistance() < 32 and floorRay.is_colliding():
		vel.y = -150
		vel.x = dir * 60
	
	if randi() % 250 == 0 and floorRay.is_colliding(): # random jump
		vel.y = -150
		vel.x = dir * 60
		
	if getWater() > 0.5:
		vel.y -= floatamount * 60 * delta
	
	setVelocity(vel)
	
	move_and_slide()
	
	animation(dir,delta)

func smack():
	state = 2

func stunned(delta):
	var vel = getVelocity()
	vel.y += 1000 * delta
	
	if floorRay.is_colliding():
		vel.x = lerp(vel.x,0.0,0.08)
	
	if getWater() > 0.5:
		vel.y -= floatamount * 60 * delta
	
	setVelocity(vel)
	
	move_and_slide()
	
	animation(0,delta)
	
	if abs(vel.x) < 10:
		state = 1

func animation(dir,delta):
	
	if dir != 0:
		sprite.flip_h = dir == -1
		
		match int(animTick):
			0:
				sprite.frame = 1
			12:
				sprite.frame = 0
			24:
				sprite.frame = 2
			36:
				sprite.frame = 0
			48:
				sprite.frame = 1
				animTick = -1
		
		animTick += 1
		
	else:
		sprite.frame = 0
		animTick = 0
	
	if !floorRay.is_colliding():
		sprite.frame = 3
		return
