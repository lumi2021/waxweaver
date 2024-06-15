extends Node2D

@onready var damageIndicator = preload("res://ui_scenes/damageIcons/damage_indicator.tscn")


func damnPopup(amount:int,pos:Vector2,type:String="normal"):
	var ins = damageIndicator.instantiate()
	ins.global_position = pos
	ins.number = amount
	ins.type = type
	add_child(ins)
