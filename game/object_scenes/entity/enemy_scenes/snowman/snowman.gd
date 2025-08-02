extends Enemy

@onready var sprite = $Sprite
@onready var onFloorRay = $Sprite/RayCast2D
var idleTicks :int= 0

func _process(delta):
	
	
	sprite.rotation = getWorldRot(self)
	
	var vel = getVelocity()
	
	vel.y += 1000 * delta
	
	
	if onFloorRay.is_colliding():
		vel.x = lerp( vel.x, 0.0, 0.2 )
		idleTicks += 1
		
		if idleTicks % 10 == 0:
			sprite.frame = abs(sprite.frame - 1)
		
		if idleTicks > 140:
			sprite.frame = 1
			sprite.offset.x =  ((idleTicks % 2) * 2) - 1
			
		if idleTicks > 180:
			var strong = randi_range(200,300)
			var dir = getDirectionTowardsPlayer()
			sprite.flip_h = dir == 1
			sprite.offset.x = 0
			
			vel = Vector2( dir * strong, -strong )
			idleTicks = -10
			sprite.frame = 0
	else:
		sprite.offset.x = 0
	
	
	setVelocity(vel)
	move_and_slide()
