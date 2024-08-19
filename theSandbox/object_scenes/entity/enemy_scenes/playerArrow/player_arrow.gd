extends Enemy

var damage :int= 3
var speed :float= 10.0

var dir :Vector2= Vector2.ZERO

var deletable = true

var tex :Texture2D

var statusInflictors :Array[StatusInflictor] = []


func _ready():
	setVelocity(dir.normalized() * speed)
	$axis/Hurtbox.damage = damage
	$axis/Hurtbox.statusInflictors = statusInflictors
	$axis.rotation = velocity.angle()
	
	$axis/Arrow.texture = tex
	
	#await get_tree().create_timer(0.1).timeout
	#$CollisionShape2D.disabled = false
	#$axis/Arrow.visible = true
	#deletable = true

func _process(delta):
	var vel = getVelocity()
	
	vel.y += 400 * delta
	
	setVelocity(vel)
	move_and_slide()
	
	$axis.rotation = velocity.angle()
	
	
	$poop.rotation = getQuad(self) * (PI/2)
	
	if deletable:
		if $poop/RayCast2D.is_colliding() or $poop/RayCast2D2.is_colliding():
			queue_free()

func _on_hurtbox_hitsomething():
	queue_free()

