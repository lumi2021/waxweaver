extends Node

@onready var parent = get_parent()
@onready var planet =get_parent().get_parent().get_parent()

func _process(delta):
	var tile = planet.posToTile(parent.position)
	var chunk = Vector2(int(tile.x)/8,int(tile.y)/8)
	if !planet.chunkDictionary.has(chunk):
		parent.queue_free()
	
