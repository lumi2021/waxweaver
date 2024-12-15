extends CharacterBody2D

@onready var sprite = $sprite

var direction :Vector2 = Vector2(1,0)
var planet :Planet = null

var blockID :int= 2

var ticks :int= 0

var blockData

var info :int= 0

func _ready():
	
	if !is_instance_valid(planet):
		queue_free()
		return
	
	velocity = direction * 200.0
	
	blockData = BlockData.theChunker.getBlockDictionary(blockID)
	var img = blockData["texture"].get_image()
	img.crop(8,8)
	sprite.texture = ImageTexture.create_from_image(img)

func _process(delta):
	var collider = move_and_collide( velocity*delta )
	if collider: # has hit wall
		
		# get position
		var tile = planet.posToTile(position)
		
		if planet.DATAC.getTileData(tile.x,tile.y) > 1:
			
			BlockData.spawnBreakParticle(tile.x,tile.y,blockID,blockData["breakParticleID"],planet,0,true)
			BlockData.spawnGroundItem(tile.x,tile.y,blockData["itemToDrop"],planet)
			
			queue_free()
			return
		
		planet.DATAC.setInfoData(tile.x,tile.y,info)
		planet.editTiles( { Vector2i( tile.x,tile.y ):blockID },true )
		
		if ticks != 0:
			queue_free()
	#sprite.rotate(6.0*delta)
	
	ticks += 1
