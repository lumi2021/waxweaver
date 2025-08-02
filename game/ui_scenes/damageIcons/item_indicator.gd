extends Node2D

var velocity :Vector2 = Vector2.ZERO
var tick = 0

var text :String= ""

var money :int = -1

func _ready():
	rotation = GlobalRef.camera.rotation
	
	$Label.text = text
	
	if money > 0:
		$Label.text = "+$" + str(money)
		modulate = Color.DARK_TURQUOISE
		modulate.a = 0.5
	
	velocity = Vector2(1,0).rotated(randf_range(-PI,PI))
	position += Vector2(0,-26).rotated(rotation)
	velocity.y = abs(velocity.y) * -2.5
	velocity = velocity.rotated(rotation)
	
	await get_tree().create_timer(0.5).timeout
	queue_free()

func _process(delta):
	tick += 60 * delta
	position += velocity * 60 * delta
	
	var l = 1 - pow(2, ( -delta/0.03803 ) )
	velocity = lerp(velocity,Vector2.ZERO,l)
	
	#modulate.a = 0.5 + (sin(tick * flashSpeed) * 0.25)
	

