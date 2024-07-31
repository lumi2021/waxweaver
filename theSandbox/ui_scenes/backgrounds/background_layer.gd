extends Node2D

@export var texture :Texture2D
@export var scrollAmount :Vector2 = Vector2(1,1)
var ar :Array[Vector2]= [Vector2.ZERO,Vector2(1,0),Vector2(0,1),Vector2(1,1)]

@onready var origin = $origin

var s :Vector2= Vector2.ZERO

func _ready():
	s = texture.get_size()
	
	for i in range(4):
		var ins = Sprite2D.new()
		ins.texture = texture
		ins.centered = false
		ins.position = ar[i] * s
		origin.add_child(ins)
	
	Background.backgroundScrolled.connect(scroll)

func scroll(amount:Vector2):
	origin.position += amount * scrollAmount
	
	if origin.position.x > 0:
		origin.position.x -= s.x
	if origin.position.y > 0:
		origin.position.y -= s.y
	if origin.position.x < -s.x:
		origin.position.x += s.x
	if origin.position.y < -s.y:
		origin.position.y += s.y
