extends Node2D

@onready var raycast = $RayCast2D
@onready var hurtbox = $Hurtbox
@onready var line = $Line2D

var damage :int = 3
var statusInflictors :Array[StatusInflictor] = []
var dir :Vector2= Vector2(1,0)



func _ready():
	
	hurtbox.damage = damage
	hurtbox.statusInflictors = statusInflictors
	
	raycast.target_position = dir * 600
	raycast.force_raycast_update()
	
	var point = (dir * 600) + global_position
	
	if raycast.is_colliding():
		point = raycast.get_collision_point()
		
		if raycast.get_collider() is Area2D:
			# means we've hit a hitbox
			var hitbox = raycast.get_collider()
			hitbox._on_area_entered(hurtbox)
	
	line.add_point(Vector2.ZERO)
	line.add_point(point - global_position)
	
	var tween = get_tree().create_tween()
	tween.tween_property(line,"modulate:a",0.0,0.2)
	
	await tween.finished
	
	queue_free()
