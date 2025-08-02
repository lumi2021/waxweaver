extends CharacterBody2D

var dead :bool= false

func _ready():
	$start.emitting = true

func _process(delta):
	if dead:
		return
	var t = to_local(GlobalRef.player.global_position).normalized()
	
	var speed :float= 200.0
	var dot = velocity.normalized().dot( to_local(GlobalRef.player.global_position).normalized() )
	if dot > 0.8:
		speed = 240.0
	
	velocity = lerp(velocity,t*speed,1.0 - pow(0.05,delta))
	var c = move_and_collide(velocity * delta)
	
	if c:
		startDelete()

func startDelete():
	dead = true
	$flame.emitting = false
	$end.emitting = true
	$Hurtbox/CollisionShape2D.call_deferred("set_disabled",true)


func _on_end_finished():
	queue_free()


func _on_hurtbox_hitsomething():
	startDelete()
