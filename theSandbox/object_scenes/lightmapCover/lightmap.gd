extends Node2D

@onready var sprite = $Sprite2D
@onready var cppLightmap = $LIGHTMAP
@onready var dropShadow = $dropShadow

var newImg = null

func _ready():
	GlobalRef.lightmap = self
	
	sprite.material.set_shader_parameter("lightingMask",GlobalRef.lightRenderVP.get_texture())
	$dropShadow.texture = GlobalRef.dropShadowRenderVP.get_texture()

func _process(delta):
	dropShadow.position = Vector2(1,1).rotated(GlobalRef.camera.rotation)

func pushUpdate(planet,newPos):
	var pSize = planet.SIZEINCHUNKS * 32 #Pixel diameter of planet
	newPos += planet.position
	var relativePos = (newPos - planet.global_position) + Vector2(pSize,pSize)

	var newX = int(relativePos.x)/8
	var newY = int(relativePos.y)/8

	cppLightmap.generateLightTexture(newX,newY,planet.DATAC)
	
	position.x = int(newPos.x)
	position.y = int(newPos.y)
	GlobalRef.lightRenderVP.cam.global_position = global_position
	GlobalRef.dropShadowRenderVP.cam.global_position = global_position

func _on_lightmap_image_updated(node, image):
	sprite.texture = ImageTexture.create_from_image(image)
	
