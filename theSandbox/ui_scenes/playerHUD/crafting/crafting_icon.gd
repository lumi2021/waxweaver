extends CenterContainer

@onready var sprite = $TextureRect
@onready var label = $txt/txt

var craftID = 0
var data
var canCraft = true
var inv = [[],[]]

var parent = null



func _ready():
	data = CraftData.getCraft(craftID)
	
	sprite.texture = ItemData.getItem(data["crafts"]).texture
	label.text = str(data["amount"])
	
	for i in range(data["ingredients"].size()):
		if !inv[0].has(data["ingredients"][i]):
			canCraft = false
			break
		else:
			var arraypos = inv[0].find(data["ingredients"][i])
			if inv[1][arraypos] < data["ingAmounts"][i]:
				canCraft = false
				break
	vis()

func vis():
	$CraftingIcon.visible = canCraft
	$CantCraft.visible = !canCraft
	


func updateMe():
	for i in data["ingredients"].size():
		if PlayerData.checkForItemAmount(data["ingredients"][i]) < data["ingAmounts"][i]:
			canCraft = false
			return # can not craft again
	canCraft = true # can craft again
	vis()


func _on_craft_button_mouse_entered():
	get_parent().get_parent().get_parent().displayCraftingInfo(craftID)


func _on_craft_button_mouse_exited():
	get_parent().get_parent().get_parent().displayCraftingInfo(null)


func _on_craft_button_pressed():
	if canCraft:
		var cra = PlayerData.craftItem(data)
		if cra != null:
			canCraft = cra
		vis()
