extends Area2D
class_name Hitbox

@export var healthComponent :HealthComponent = null

@export var enemyBox :bool = true
@export var invincTime :float = 0.01

@export var colliderShape :CollisionShape2D = null

func _ready():
	if healthComponent == null:
		print("Error, entity has no health component")
		queue_free()
	if colliderShape == null:
		print("Error, entity has no hitbox collision shape")
		queue_free()





func _on_area_entered(area):
	#check for invalid area
	if !area is Hurtbox:
		return
	if enemyBox == area.enemyBox:
		return
	#is now valid hurtbox
	
	# get dir for knockback
	var dir = global_position - area.global_position
	
	
	healthComponent.damage(area.damage)
	healthComponent.dealKnockback(120.0,dir)
	
	colliderShape.call_deferred("set_disabled",true)
	await get_tree().process_frame
	await get_tree().create_timer(invincTime).timeout
	colliderShape.call_deferred("set_disabled",false)
