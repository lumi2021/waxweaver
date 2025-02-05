extends Node2D

var hc :HealthComponent

func _ready():
	$Hitbox.healthComponent = hc
