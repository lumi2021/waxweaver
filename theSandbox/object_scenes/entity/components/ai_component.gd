extends Node
class_name AIComponent

@export var aiCode :EnemyAI = null

@onready var parent = get_parent()

func _ready():
	aiCode.onSpawn(parent)

func _process(delta):
	aiCode.onFrame(delta,parent)


