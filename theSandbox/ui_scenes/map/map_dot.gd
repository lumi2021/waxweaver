extends Node2D

var rootNode = null
var tiedNode = null

var sc := 768.0

func _ready():
	if tiedNode is Planet:
		var size = tiedNode.SIZEINCHUNKS * 32.0
		$Thing.scale = (Vector2(1,1) * size) / 1024.0
	else:
		$Thing.scale = Vector2(1,1)
	
	$Thing.scale.x = max($Thing.scale.x,1) # assure dot is not so small its invisible
	$Thing.scale.y = max($Thing.scale.y,1)

func _process(delta):
	if is_instance_valid(tiedNode) and is_instance_valid(rootNode):
		position = (tiedNode.global_position - rootNode.position) / 1024.0
