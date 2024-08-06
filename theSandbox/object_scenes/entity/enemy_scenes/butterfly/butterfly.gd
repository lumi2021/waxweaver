extends Enemy

@export var groundCast:RayCast2D
@export var airCast:RayCast2D
@export var HC:HealthComponent
@export var spr:Sprite2D

var tick :float= 0
var animTick = 0

func _ready():
	spr.frame_coords.y = randi() % 6
	spr.frame_coords.x = randi() % 2

func _process(delta):
	var vel = getVelocity()
	
	var targetX :float= (randi() % 3) - 1
	var targetY :float= (randi() % 3) - 1
	
	if !groundCast.is_colliding():
		targetY = 1
	if airCast.is_colliding():
		targetY = -1
	
	vel = Vector2( lerp(vel.x,targetX * 100,0.01), lerp(vel.y,targetY * 100,0.02)  )
	
	spr.flip_h = vel.x < -1
	
	setVelocity(vel)
	move_and_slide()
	
	tick += delta
	
	animTick += delta
	if animTick > 0.5:
		spr.frame_coords.x = int( spr.frame_coords.x == 0 )
		animTick -= 0.5
	
	groundCast.target_position = Vector2(0,64).rotated( getQuad(self) )
	spr.rotation = getQuad(self) * (PI/2)
	
	if getWater() > 0.5:
		HC.damage(1)
