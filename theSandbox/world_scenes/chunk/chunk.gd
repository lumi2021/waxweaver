extends Node2D

@onready var mainLayerSprite = $mainLayer
@onready var backLayerSprite = $backLayer
@onready var body = $StaticBody2D

const CHUNKSIZE :int= 8

var pos :Vector2= Vector2.ZERO

var onScreen :bool= false

var id4 :int= 0

var MUSTUPDATELIGHT :bool= false

var planet = null

func _ready():
	
	planet = get_parent().get_parent()
	
	drawData()

	id4 = (int(pos.x) % 2)+((int(pos.y) % 2)*2)
	#id4 = (pos.x % 2)+((pos.y % 4)*2)
	
	set_process(false)

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
	var images = BlockData.theChunker.generateTexturesFromData(planet.DATAC,pos,body,shape)
	mainLayerSprite.texture = ImageTexture.create_from_image(images[0])
	backLayerSprite.texture = ImageTexture.create_from_image(images[1])
	
	return

	
func getBlockPosition(x,y):
	return planet.positionLookup[x][y]

func clearCollisions():
	for i in body.get_children():
		i.queue_free()

func _on_visible_on_screen_notifier_2d_screen_entered():
	body.set_process(true)
	onScreen = true
	if !planet.visibleChunks.has(self):
		planet.visibleChunks.append(self)
	mainLayerSprite.visible = onScreen
	backLayerSprite.visible = onScreen
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	body.set_process(false)
	onScreen = false
	planet.visibleChunks.erase(self)
	mainLayerSprite.visible = onScreen
	backLayerSprite.visible = onScreen
