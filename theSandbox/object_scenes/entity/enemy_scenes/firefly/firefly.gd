extends Enemy

@export var groundCast:RayCast2D
@export var airCast:RayCast2D
@export var HC:HealthComponent

var tick :float= 0

func _process(delta):
	var vel = getVelocity()
	
	var targetX :float= (randi() % 3) - 1
	var targetY :float= (randi() % 3) - 1
	
	if !groundCast.is_colliding():
		targetY = 1
	if airCast.is_colliding():
		targetY = -1
	if !GlobalRef.isNight():
		
		targetY = -0.2
	
	vel = Vector2( lerp(vel.x,targetX * 100,0.01), lerp(vel.y,targetY * 100,0.02)  )
	
	setVelocity(vel)
	move_and_slide()
	
	tick += delta
	
	groundCast.target_position = Vector2(0,64).rotated( getQuad(self) )
	
	if getWater() > 0.5:
		HC.damage(1)
	
	setLight(1.0)
