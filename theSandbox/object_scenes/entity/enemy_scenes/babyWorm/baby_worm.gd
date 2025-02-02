extends CharacterBody2D

@onready var bodyLine = $Line2D
@onready var segmentContainer = $segments

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
