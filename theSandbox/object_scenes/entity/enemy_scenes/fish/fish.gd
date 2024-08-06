extends Enemy

@export var floorRay :RayCast2D
@export var spr :Sprite2D

var state = 0 # 0 in water, 1 out of water

var tick = 0

var targetX :float= 0
var targetY :float= -1

func _process(delta):
	
	state = int(abs(getWater())< 0.5)
	
	var vel = getVelocity()
	if state == 0:
		
		if tick > 0.6:
			targetX = (randi() % 3) - 1
			targetY = (randi() % 3) - 1
			tick -= 0.6
		
		if floorRay.is_colliding():
			targetY = -1
		
		
		vel = Vector2( lerp(vel.x,targetX * 40,0.05), lerp(vel.y,targetY * 20,0.02)  )
		
	else:
		
		if floorRay.is_colliding():
			targetX = (randi() % 3) - 1
			vel.y -= 100
		
		vel.x = lerp(vel.x,targetX * 80,0.05)
		vel.y += 1000 * delta
		
		
	setVelocity(vel)
	move_and_slide()
		
	tick += delta
	
	spr.flip_h = vel.x < 0
	
	var base = (PI/2) * getQuad(self)
	if spr.flip_h:
		spr.rotation = lerp_angle(spr.rotation,base + (-0.05 * vel.y),0.1)
	else:
		spr.rotation = lerp_angle(spr.rotation,base + (0.05 * vel.y),0.1)

