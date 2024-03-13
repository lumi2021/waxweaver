extends Node2D

@onready var container = $ScrollContainer/GridContainer
@onready var iconScene = preload("res://ui_scenes/playerHUD/crafting/crafting_icon.tscn")

func createCraftingIcons():
	clearIcons()
	var inv = PlayerData.getItemTotals() # gets all items and amounts
	var craftsToDisplay = []
	for i in range(inv[0].size()):
		var itemdata = ItemData.getItem(inv[0][i]) # item data
		var amount = inv[1][i] # amount in inventory rn
		for craft in itemdata.materialIn:
			if !craftsToDisplay.has(craft):
				craftsToDisplay.append(craft)
	for craft in craftsToDisplay:
		createIcon(craft)

func createIcon(craftID):
	var ins = iconScene.instantiate()
	ins.craftID = craftID
	container.add_child(ins)

func clearIcons():
	for c in container.get_children():
		c.queue_free()
