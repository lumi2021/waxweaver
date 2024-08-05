extends Node

@onready var parent = get_parent()
@onready var planet = get_parent().get_parent().get_parent()

var checkTick :int = 0
var checkRand :int = 0

func _ready():
	checkRand = randi() % 4

func _process(delta):

	if checkTick % 4 == checkRand:
		var tile = planet.posToTile(parent.position)
		var chunk = Vector2(int(tile.x)/8,int(tile.y)/8)
		if !planet.chunkDictionary.has(chunk):
			CreatureData.creatureDeleted(parent)
			parent.queue_free()
	checkTick += 1
