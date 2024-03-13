extends CenterContainer

@onready var sprite = $TextureRect
@onready var label = $txt/txt

var craftID = 0
var data

func _ready():
	data = CraftData.getCraft(craftID)
	
	sprite.texture = ItemData.getItem(data["crafts"]).texture
	label.text = str(data["amount"])
