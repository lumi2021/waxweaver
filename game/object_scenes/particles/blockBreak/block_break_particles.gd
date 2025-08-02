extends CPUParticles2D

@onready var sound = $AudioStreamPlayer2D

var textureID = 0
var ticks = 0

var infoID = 0
var blockID = 0

var doneByPlayer :bool = false

func _ready():
	
	if textureID < 2:
		queue_free()
	
	var blockData = BlockData.theChunker.getBlockDictionary(textureID)
	texture = blockData["texture"]
	if doneByPlayer:
		playsound()
	else:
		var dis = global_position.distance_to( GlobalRef.player.global_position )
		if dis < 200:
			playsound()
	
	if blockData["multitile"]:
		var img = texture.get_image()
		var croppedImg :Image= img.get_region( Rect2i( Vector2i(infoID*8,0), Vector2i(8,8) ) )
		var tex = ImageTexture.create_from_image(croppedImg)
			
		texture = tex
	elif blockData["connectedTexture"]:
		var img = texture.get_image()
		var croppedImg :Image= img.get_region( Rect2i( Vector2i(0,0), Vector2i(8,8) ) )
		var tex = ImageTexture.create_from_image(croppedImg)
			
		texture = tex
	elif blockData["animated"]:
		var img = texture.get_image()
		var croppedImg :Image= img.get_region( Rect2i( Vector2i(0,0), Vector2i(8,8) ) )
		var tex = ImageTexture.create_from_image(croppedImg)
			
		texture = tex
	
	one_shot = true
	emitting = true

func _process(delta):
	ticks += delta * 60
	if ticks > 45:
		queue_free()

func playsound():
	sound.stream = SoundManager.getBreakSound(blockID)
	sound.volume_db = SoundManager.blockBreakVol
	sound.pitch_scale = randf_range(0.9,1.1)
	sound.play()

