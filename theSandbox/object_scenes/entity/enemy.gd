extends CharacterBody2D

@onready var stats = $EntityStats
@export var scriptAI :Resource = null

@onready var planet = get_parent().get_parent()

func _ready():
	if !is_instance_valid(scriptAI):
		printerr("I spawned without any AI! : " + str(self))
		queue_free()
	
	$Collider.shape.size = Vector2(scriptAI.hitboxSize,scriptAI.hitboxSize)
	stats.maxHealth = scriptAI.maxHealth
	stats.defense = scriptAI.defense
	stats.knockbackResist = scriptAI.knockbackResist
	stats.attackDamage = scriptAI.attackDamage
	stats.enemyResource = scriptAI

func _process(delta):
	scriptAI.onFrame(delta,self)
