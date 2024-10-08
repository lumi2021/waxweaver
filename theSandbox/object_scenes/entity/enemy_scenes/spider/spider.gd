extends Enemy

var state = 0 #  0 = attacking, 1 = falling, 2 = smacked

@export var sprite :Sprite2D

var smackTick = 0
var step :float= 0

func _process(delta):
	match state:
		0:
			hunt(delta)
		1:
			fall(delta)
		2:
			smacked(delta)

func hunt(delta):
	var vel = getVelocity()
	
	var targetX = getDirectionTowardsPlayer()
	var targetY = getVERTICALDirectionTowardsPlayer()
	
	var t = Vector2( targetX,targetY ).normalized() * 60.0
	
	var l = 1-pow(2, (-delta/0.38) )
	vel = lerp( vel, t, l )
	
	setVelocity(vel)
	move_and_slide() 
	
	sprite.rotation = vel.angle()
	
	if getWall() < 2:
		state = 1
	
	step += delta
	if step > 0.1:
		step -= 0.1
		if sprite.frame < 2:
			sprite.frame += 1
		else:
			sprite.frame = 0

func fall(delta):
	var vel = getVelocity()
	
	vel.y += 1000 * delta
	
	setVelocity(vel)
	move_and_slide()
	
	sprite.rotate(delta)
	sprite.frame = 3
	
	if getWall() > 1:
		state = 0

func smacked(delta):
	smackTick -= 60*delta
	var vel = getVelocity()
	
	vel.y += 1000 * delta
	
	setVelocity(vel)
	move_and_slide()
	
	sprite.rotate(delta*6.0)
	sprite.frame = 3
	
	if smackTick <= 0:
		sprite.frame = 0
		if getWall() > 1:
			state = 0
		else:
			state = 1

func _on_health_component_smacked():
	smackTick = 20
	state = 2
