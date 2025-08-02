extends Enemy

@export var groundCast:RayCast2D
@export var airCast:RayCast2D
@export var HC:HealthComponent
@export var spr:Sprite2D

var tick :float= 0
var animTick = 0

var targetX :float= 0
var targetY :float= -1

func _ready():
	spr.frame_coords.y = randi() % 6
	spr.frame_coords.x = randi() % 2

func _process(delta):
	var vel = getVelocity()
	
	
	if tick > 0.016:
		targetX = (randi() % 3) - 1
		targetY = (randi() % 3) - 1
		tick -= 0.016
	
	if !groundCast.is_colliding():
		targetY = 1
	if airCast.is_colliding():
		targetY = -1
	if GlobalRef.isNight():
		targetY = -0.2
		
	var l = 1 - pow(2, ( -delta/3.803 ) )
	vel = Vector2( lerp(vel.x,targetX * 100,l), lerp(vel.y,targetY * 100,l*2.0)  )
	
	spr.flip_h = vel.x < -1
	
	setVelocity(vel)
	move_and_slide()
	
	tick += delta
	
	animTick += delta
	if animTick > 0.5:
		spr.frame_coords.x = int( spr.frame_coords.x == 0 )
		animTick -= 0.5
	
	groundCast.target_position = Vector2(0,64).rotated( (PI/2) * getQuad(self) )
	airCast.target_position = Vector2(0,20).rotated( (PI/2) * getQuad(self) )
	spr.rotation = getQuad(self) * (PI/2)
	
	if getWater() > 0.5:
		HC.damage(1)
