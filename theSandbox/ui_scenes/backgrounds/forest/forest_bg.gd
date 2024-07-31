extends Node2D


func _process(delta):
	$backgroundLayer.scroll(Vector2(30*delta,0))
