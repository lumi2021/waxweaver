extends Node2D

@onready var sprite = $Sprite2D
@onready var cppLightmap = $LIGHTMAP


var newImg = null

func _ready():
	GlobalRef.lightmap = self
	

func pushUpdate(planet,newPos):
	var pSize = planet.SIZEINCHUNKS * 32 #Pixel diameter of planet
	newPos += planet.position
	var relativePos = (newPos - planet.global_position) + Vector2(pSize,pSize)

	var newX = int(relativePos.x)/8
	var newY = int(relativePos.y)/8

	cppLightmap.generateLightTexture(newX,newY,planet.DATAC)
	
	position = newPos

func _on_lightmap_image_updated(node, image):
	sprite.texture = ImageTexture.create_from_image(image)
