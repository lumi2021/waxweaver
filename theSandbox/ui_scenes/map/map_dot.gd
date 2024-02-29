extends Node2D

var rootNode = null
var tiedNode = null

func _process(delta):
	if is_instance_valid(tiedNode) and is_instance_valid(rootNode):
		position = (tiedNode.global_position - rootNode.position) / 512.0
