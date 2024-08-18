extends Resource
class_name StatusEffect

@export var displayName :String= ""
@export var icon :Texture2D

var healthComponent :HealthComponent
var time := 1.0
var name := ""

@export var dyeColor :Color = Color.WHITE
@export var particle :PackedScene
var p = null

## having any of these effects will banish this effect
@export var incompatibleEffects :Array[String] = []

signal timesUp

func proc(delta):
	time -= delta
	onFrame(delta)
	
func onInfliction():
	if is_instance_valid(healthComponent):
		healthComponent.get_parent().modulate *= dyeColor

func onGone():
	if is_instance_valid(healthComponent):
		healthComponent.get_parent().modulate /= dyeColor
	if is_instance_valid(p):
		p.queue_free()

func onFrame(delta):
	pass
