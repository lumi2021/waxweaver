extends Node2D

var planet = null
var planetDir = 0
var tileX :int= 0
var tileY :int= 0
var blockID = 0

var damage = 0

var mineMultiplier := 1.0

var baseRotation = 0

@onready var texture = $blockTexture

func _ready():
	
	if !is_instance_valid(planet):
		return
	
	var blockData = BlockData.theChunker.getBlockDictionary(blockID)
	texture.texture = blockData["texture"]
	
	if blockData["breakParticleID"] == -1:
		$particles.texture = blockData["texture"]
	else:
		var particleData = BlockData.theChunker.getBlockDictionary(blockData["breakParticleID"])
		$particles.texture = particleData["texture"]
	
	if blockData["connectedTexture"]:
		texture.hframes = 16
		texture.frame = BlockData.theChunker.scanBlockOpen(planet.DATAC,tileX,tileY,planetDir * int(blockData["rotateTextureToGravity"])) / 8
		$Sprite.hframes = 16
		$Sprite.frame = texture.frame
	elif blockData["multitile"]:
		texture.hframes = texture.texture.get_size().x / 8
		texture.frame = planet.DATAC.getInfoData(tileX,tileY)
		$Sprite.hframes = texture.hframes
		$Sprite.frame = texture.frame
	
	if blockData["animated"]:
		texture.vframes = 3
		$Sprite.vframes = 3
	
	if blockData["rotateTextureToGravity"]:
		texture.rotation = (PI/2) * planet.getBlockPosition(tileX,tileY)
		baseRotation = texture.rotation
		$Sprite.rotation = texture.rotation
		
	$Sprite.texture = blockData["texture"]
	

func _process(delta):
	
	#this shit sucks fix it
	
	if planet == null:
		print_debug("BLOCK BREAK HAS NO PLANET ASSIGNED")
		return
	
	if Input.is_action_pressed("mouse_left"):
		var itemData = ItemData.data[PlayerData.inventory[PlayerData.selectedSlot][0]]
		if itemData is ItemMining:
			damage += delta * itemData.miningMultiplier
			var breakTime = BlockData.theChunker.getBlockDictionary(blockID)["breakTime"]
			texture.position.x = ((randi() % 3)-1) * (damage / breakTime)
			texture.position.y = ((randi() % 3)-1) * (damage / breakTime)
			texture.rotation = baseRotation + ((randi() % 3)-1) * (damage / breakTime) * 0.1
			
			if damage >= breakTime:
				var edit = Vector2i(tileX,tileY)
				planet.editTiles( { edit: -1 } )
				GlobalRef.player.lastTileItemUsedOn = Vector2(-10,-10)
				queue_free()
		else:
			queue_free()
	else:
		queue_free()
	
	var mousePos = to_local(get_global_mouse_position())
	if abs(mousePos.y) > 4:
		queue_free()
	if abs(mousePos.x) > 4:
		queue_free()
