extends Node2D

var rootNode = null
var tiedNode = null

var sc := 256.0

func _ready():
	if tiedNode is Planet:
		var size = tiedNode.SIZEINCHUNKS * 32.0
		$Thing.scale = (Vector2(1,1) * size) / sc

func _process(delta):
	if is_instance_valid(tiedNode) and is_instance_valid(rootNode):
		position = (tiedNode.global_position - rootNode.position) / 512.0
		if tiedNode is Planet:
			var size = tiedNode.SIZEINCHUNKS * 32.0
			$Thing.scale = (Vector2(1,1) * size) / 512.0
