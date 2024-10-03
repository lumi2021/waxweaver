extends Area2D
class_name Hurtbox

@export var enemyBox :bool = true
@export var damage :int = 1
@export var knockback : float = 1.0

@export var enemyName :String = "enemy" # name to print if player dies

@export var statusInflictors :Array= []

var id = 0

signal hitsomething

func _ready():
	shuffleId()

func shuffleId():
	id = randi()

func hasHit():
	emit_signal("hitsomething")
