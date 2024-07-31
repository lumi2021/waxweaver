extends Node2D

@export var gradient :Gradient



func _process(delta):
	
	$Sprite2D.modulate = gradient.sample(GlobalRef.currentTime)
	modulate.a = GlobalRef.daylightMult
