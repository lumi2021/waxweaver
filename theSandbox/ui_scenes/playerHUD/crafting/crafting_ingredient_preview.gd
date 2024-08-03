extends Node2D

var amount = 0
var itemName = ""
var spr = null
var has = true

func _ready():
	$Label.text = itemName + " x " + str(amount)
	$sprite.texture = spr
	
	if !has:
		$Label.modulate = Color.RED
