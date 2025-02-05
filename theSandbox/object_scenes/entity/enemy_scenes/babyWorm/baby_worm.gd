extends Enemy

@onready var segmentScene = preload("res://object_scenes/entity/enemy_scenes/babyWorm/baby_worm_segment.tscn")
@onready var bodyLine = $Line2D
@onready var segmentContainer = $segments

func _ready():
	for i in range(40):
		var ins = segmentScene.instantiate()
		ins.hc = $HealthComponent
		segmentContainer.add_child(ins)

func _process(delta):
	var pos = position
	velocity = to_local(GlobalRef.player.global_position) * 0.5
	move_and_slide()
	
	moveBody(pos,position)

func moveBody(oldPos:Vector2,newPos:Vector2):
	var change :Vector2 = newPos - oldPos
	var previousSegment = self
	bodyLine.clear_points()
	
	bodyLine.add_point(Vector2.ZERO)
	for segment in segmentContainer.get_children():
		segment.position -= change
		
		var segmentSpace :Vector2= segment.global_position - previousSegment.global_position
		if segmentSpace.length() > 4:
			segment.global_position = previousSegment.global_position + (segmentSpace.normalized() * 24)
		
		
		previousSegment = segment
		bodyLine.add_point(segment.position)
