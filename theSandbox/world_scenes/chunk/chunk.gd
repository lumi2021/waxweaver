extends Node2D

@onready var mainLayerSprite = $mainLayer
@onready var backLayerSprite = $backLayer
@onready var waterLayerSprite = $waterLayer
@onready var body = $StaticBody2D

const CHUNKSIZE :int= 8

var pos :Vector2= Vector2.ZERO

var onScreen :bool= false

var id4 :int= 0

var MUSTUPDATELIGHT :bool= false

var planet :Planet= null

func _ready():
	
	planet = get_parent().get_parent()
	
	pos = position
	position = (pos * 64) - Vector2(planet.SIZEINCHUNKS*32,32*planet.SIZEINCHUNKS)
	

	id4 = (int(pos.x) % 2)+((int(pos.y) % 2)*2)
	
	set_process(false)
	body.set_process(false)
	
	drawData()

func tickUpdate():
	
	MUSTUPDATELIGHT = true
	# call c++ and return
	return BlockData.theChunker.tickUpdate(planet.DATAC,pos)

func drawData():
	
	#CreateShape
	var shape = RectangleShape2D.new()
	shape.size = Vector2(8,8)
	clearCollisions()

	# Call c++
	var images = BlockData.theChunker.generateTexturesFromData(planet.DATAC,pos,body,shape,false)
	mainLayerSprite.texture = ImageTexture.create_from_image(images[0])
	backLayerSprite.texture = ImageTexture.create_from_image(images[1])
	
	drawLiquid()
	return

func drawLiquid():
	var images = BlockData.theChunker.drawLiquid(planet.DATAC,pos,false)
	waterLayerSprite.texture = ImageTexture.create_from_image(images[0])

func clearCollisions():
	for i in body.get_children():
		i.queue_free()

func _on_visible_on_screen_notifier_2d_screen_entered():
	onScreen = true
	if !planet.visibleChunks.has(self):
		planet.visibleChunks.append(self)
	mainLayerSprite.visible = onScreen
	backLayerSprite.visible = onScreen
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	onScreen = false
	planet.visibleChunks.erase(self)
	mainLayerSprite.visible = onScreen
	backLayerSprite.visible = onScreen

#debug
func flicker(show):
	$Icon.visible = show
