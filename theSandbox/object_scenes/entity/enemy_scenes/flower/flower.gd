extends Enemy

@export var HC : HealthComponent
@export var rotationOrigin : Node2D
@export var sprite:Sprite2D
@export var wallWay :RayCast2D
@export var floorRay :RayCast2D

var state = 0 # 0 = idle, 1 = flee, 2 = stunned

var wanderDir = 1
var animTick = 0
var floatamount = 25.0

func _ready():
	HC.connect("smacked",smack)
	wanderDir = ((randi() % 2) * 2) - 1

func _physics_process(delta):
	match state:
		0:
			idle(delta)
		1:
			flee(delta)
		2:
			stunned(delta)

func idle(delta):
	
	var vel = getVelocity()
	vel.y += 1000 * delta
	setVelocity(vel)
	move_and_slide()
	
	if getPlayerDistance() < 16:
		state = 1

func smack():
	state = 1
	
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

func flee(delta):
	var vel = getVelocity()
	
	if randi() % 20 == 0:
		wanderDir = ((randi() % 2) * 2) - 1 # gets only 1 or -1
	
	rotationOrigin.rotation = getQuad(self) * (PI/2)
	
	if floorRay.is_colliding():
		vel.x = lerp(vel.x, wanderDir * 100.0, 0.1 )
	else:
		vel.x = vel.x + (wanderDir * 1) * 60 * delta
	
	vel.y += 1000 * delta
	
	wallWay.target_position.x = 8 * wanderDir
	wallWay.force_raycast_update()
	if wallWay.is_colliding() and floorRay.is_colliding():
		vel.y = -220
	
	#if getPlayerDistance() < 36:
	#	state = 1
	
	if getWater() > 0.5:
		vel.y -= floatamount * 60 * delta
	
	setVelocity(vel)
	
	move_and_slide()
	
	animation(wanderDir,delta)

func animation(dir,delta):
	
	if dir != 0:
		sprite.flip_h = dir == -1
		
		match int(animTick):
			0:
				sprite.frame = 0
			4:
				sprite.frame = 1
			8:
				sprite.frame = 2
			12:
				sprite.frame = 3
			16:
				sprite.frame = 0
				animTick = -1
		
		animTick += 1
		
	else:
		sprite.frame = 0
		animTick = 0
