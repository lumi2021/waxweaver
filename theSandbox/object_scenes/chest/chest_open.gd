extends Node2D

@onready var sprite = $Sprite2D
var rot = 0

var pos = null
var body = null

func _ready():
	sprite.rotation = rot * (PI/2)
	set_process(false)
	await get_tree().create_timer(0.1).timeout
	sprite.frame = 1
	await get_tree().create_timer(0.1).timeout
	sprite.frame = 2
	
	set_process(true)

func _process(delta):
	if body != PlayerData.chestOBJ or pos != PlayerData.currentSelectedChest:
		end()
		set_process(false)
		return

func end():
	await get_tree().create_timer(0.1).timeout
	sprite.frame = 1
	await get_tree().create_timer(0.1).timeout
	sprite.frame = 0
	queue_free()
