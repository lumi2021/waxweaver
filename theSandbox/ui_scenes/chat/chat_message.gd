extends Node2D

var text = "empty message"
var color :Color = Color.WHITE


@onready var label = $Label

var ticks = 0

func _ready():
	modulate = color
	label.text = text

func _process(delta):
	ticks += 1
	
	if ticks > 180:
		modulate.a -= 0.01
	
	if modulate.a <= 0.0:
		queue_free()
