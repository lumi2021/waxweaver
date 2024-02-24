extends CPUParticles2D

var textureID = 0
var ticks = 0

func _ready():
	texture = BlockData.theChunker.getBlockDictionary(textureID)["texture"]
	one_shot = true
	emitting = true

func _process(delta):
	ticks += delta * 60
	if ticks > 45:
		queue_free()
