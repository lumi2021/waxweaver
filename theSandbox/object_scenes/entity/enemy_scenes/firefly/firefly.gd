extends Enemy

@export var groundCast:RayCast2D
@export var airCast:RayCast2D
@export var HC:HealthComponent

var tick :float= 0

var targetX :float= 0
var targetY :float= -1

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
	
	if getSurface() < 8.0:
		if !GlobalRef.isNight():
			targetY = -1.2
			
	
	var l = 1 - pow(2, ( -delta/3.803 ) )
	vel = Vector2( lerp(vel.x,targetX * 100,l), lerp(vel.y,targetY * 100,l*2.0)  )
	
	setVelocity(vel)
	move_and_slide()
	
	tick += delta
	
	groundCast.target_position = Vector2(0,64).rotated( (PI/2) * getQuad(self) )
	airCast.target_position = Vector2(0,20).rotated( (PI/2) * getQuad(self) )
	
	if getWater() > 0.5:
		HC.damage(1)
	
	setLight(1.0)
