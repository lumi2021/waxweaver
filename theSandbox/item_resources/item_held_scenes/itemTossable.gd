extends itemHeldClass

@onready var rotOrigin = $holder

var rotSpeed = 10.0

var swingOut = false

@onready var explosiveScene = preload("res://object_scenes/entity/enemy_scenes/explosive/explosive.tscn")

func onEquip():
	visible = false
	sprite.texture = itemData.texture

func onFirstUse():
	if swingOut:
		return
	rotOrigin.rotation_degrees = -60.0
	visible = true
	swingOut = true
	launchTossable()
	PlayerData.consumeSelected()

func onUsing(delta):
	if swingOut:
		rotOrigin.rotation_degrees += rotSpeed * delta * 60.0
		if rotOrigin.rotation_degrees > 50:
			swingOut = false
			turnOff()
	else:
		turnOff()

func onNotUsing(delta):
	if swingOut:
		rotOrigin.rotation_degrees += rotSpeed * delta * 60.0
		if rotOrigin.rotation_degrees > 50:
			swingOut = false
			turnOff()
	else:
		turnOff()

func turnOff():
	visible = false


func launchTossable():
	if itemData is ItemExplosive:
		var ins = explosiveScene.instantiate()
		ins.planet = getWorld().get_parent()
		ins.position = GlobalRef.player.position
		ins.radius = itemData.radius
		ins.bounce = itemData.bounce
		ins.delay = itemData.delay
		ins.vol = getLocalMouse().normalized() * itemData.speed
		getWorld().add_child(ins)
