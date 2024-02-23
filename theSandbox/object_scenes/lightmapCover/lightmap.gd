extends Node2D

@onready var sprite = $Sprite2D
@onready var cppLightmap = $LIGHTMAP
var size = 64


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


##Depricated light code in gdscript
#func updateLight(x,y,planet,newPos):
	#if !is_instance_valid(planet):
		#return
#
	#var data = planet.lightData
	#var blockData = planet.planetData
	#
	#var img = Image.create(size,size,false,Image.FORMAT_L8)
	#var airImg = Image.create(size,size,false,Image.FORMAT_LA8)
	#for imgX in range(size):
		#for imgY in range(size):
			#var newX = clamp(x+imgX,0,data.size()-1)
			#var newY = clamp(y+imgY,0,data.size()-1)
			#var l = data[newX][newY]
			#img.set_pixel(imgX,imgY,Color(l,l,l,1.0))
			#
	#newImg = ImageTexture.create_from_image(img)
	#
	#return
