extends Node2D

@onready var sprite = $Sprite2D
@onready var cppLightmap = $LIGHTMAP
@onready var dropShadow = $dropShadow

var newImg = null

func _ready():
	GlobalRef.lightmap = self
	
	sprite.material.set_shader_parameter("lightingMask",GlobalRef.lightRenderVP.get_texture())
	$dropShadow.texture = GlobalRef.dropShadowRenderVP.get_texture()
	
	if !Options.options["showShadow"]:
		$dropShadow.hide()
	Options.connect("updatedOptions",fuck)

func fuck():
	$dropShadow.visible = Options.options["showShadow"]

func _process(delta):
	var g = GlobalRef.camera.global_position
	var r = GlobalRef.camera.rotation
	dropShadow.global_position = g + Vector2(1,1).rotated(r)
	GlobalRef.dropShadowRenderVP.cam.global_position = g
	dropShadow.rotation = r
	GlobalRef.dropShadowRenderVP.cam.rotation = r
	
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
	#GlobalRef.dropShadowRenderVP.cam.global_position = global_position + Vector2(7,7)
	
	#GlobalRef.lightRenderVP.cam.global_position = GlobalRef.camera.global_position
	#GlobalRef.lightRenderVP.cam.rotation = GlobalRef.camera.rotation

func _on_lightmap_image_updated(node, image):
	sprite.texture = ImageTexture.create_from_image(image)
	
func toggleShadow():
	$dropShadow.visible = !$dropShadow.visible
