extends Area2D
class_name Hurtbox

@export var enemyBox :bool = true
@export var damage :int = 1

var id = 0

func _ready():
	shuffleId()

func shuffleId():
	id = randi()
