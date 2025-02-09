extends Node2D

@export var status :StatusEffect
@onready var sprite :Sprite2D= $Sprite2D

func _ready():
	if !is_instance_valid(status):
		reload()
		queue_free()
		return
	
	sprite.texture = status.icon
	$ColorRect.tooltip_text = status.displayName + ": " + status.description

func _process(delta):
	
	if !is_instance_valid(status):
		reload()
		queue_free()
		return
	
	if status.time < 60.0:
		$Label.text = str(int(status.time)) + "s"
	else:
		$Label.text = str(int(status.time)/60) + "m"
	
	if status.time <= 0.0:
		reload()
		queue_free()

func reload():
	get_parent().get_parent().updateStatus()
