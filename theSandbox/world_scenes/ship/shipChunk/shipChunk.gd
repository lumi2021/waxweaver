extends Node2D

@onready var mainLayerSprite = $mainLayer
@onready var backLayerSprite = $backLayer
@onready var waterLayerSprite = $waterLayer
@onready var animLayerSprite = $animLayer
@onready var backImmuneSprite = $backImmuneLayer

const CHUNKSIZE :int= 8

var pos :Vector2= Vector2.ZERO

var onScreen :bool= false

var id4 :int= 0

var MUSTUPDATELIGHT :bool= false

var ship = null

var collisionArray = []

func _ready():
	
	position = (pos * 64) - Vector2(ship.SIZEINCHUNKS * 32,ship.SIZEINCHUNKS * 32)
	

	id4 = (int(pos.x) % 2)+((int(pos.y) % 2)*2)
	
	set_process(false)
	
	drawData()

func tickUpdate():

	# call c++ and return
	return BlockData.theChunker.tickUpdate(ship.DATAC,pos,true,GlobalRef.daylightMult)

func drawData():
	
	#CreateShape
	var shape = RectangleShape2D.new()
	shape.size = Vector2(7.9,7.9)
	
	for c in collisionArray:
		c.queue_free()
	
	# Call c++
	var images :Array= BlockData.theChunker.generateTexturesFromData(ship.DATAC,pos,ship,shape,true)
	
	mainLayerSprite.texture = ImageTexture.create_from_image(images[images.size()-4])
	backLayerSprite.texture = ImageTexture.create_from_image(images[images.size()-3])
	animLayerSprite.texture = ImageTexture.create_from_image(images[images.size()-2])
	backImmuneSprite.texture = ImageTexture.create_from_image(images[images.size()-1])
	
	images.remove_at(images.size()-1)
	images.remove_at(images.size()-1)
	images.remove_at(images.size()-1)
	images.remove_at(images.size()-1)
	
	collisionArray = images
	

func drawLiquid():
	var images = BlockData.theChunker.drawLiquid(ship.DATAC,pos,true)
	waterLayerSprite.texture = ImageTexture.create_from_image(images[0])
