extends Node
class_name AIComponent

@export var aiCode :EnemyAI = null
@export var hC :HealthComponent = null
@export var spr : EnemySprite = null

@onready var parent = get_parent()
@onready var planet = get_parent().get_parent().get_parent()

var checkTick :int = 0
var checkRand :int = 0

func _ready():
	aiCode = aiCode.duplicate()
	aiCode.onSpawn(parent)
	checkRand = randi() % 4
	if hC != null:
		hC.connect("smacked",smacked)

func _process(delta):
	aiCode.onFrame(delta,parent)
	
	# delete enemy if chunk unloaded
	if checkTick % 4 == checkRand:
		var tile = planet.posToTile(parent.position)
		var chunk = Vector2(int(tile.x)/8,int(tile.y)/8)
		if !planet.chunkDictionary.has(chunk):
			CreatureData.creatureDeleted(parent)
			parent.queue_free()
	checkTick += 1
	
	if spr != null:
		spr.frame = aiCode.frame
		spr.flip_h = aiCode.flipped

func smacked():
	aiCode.onHit(parent)
