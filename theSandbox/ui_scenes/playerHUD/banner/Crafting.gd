extends Node2D

@onready var container = $ScrollContainer/GridContainer
@onready var iconScene = preload("res://ui_scenes/playerHUD/crafting/crafting_icon.tscn")

@onready var banner = get_parent().get_parent()

@onready var timer = $Timer

var prevCraft = []

func _ready():
	PlayerData.updateInventory.connect(createCraftingIcons)

func createCraftingIcons():
	if !banner.invOpen:
		return
	if !timer.is_stopped():
		return
	
	var inv = PlayerData.getItemTotals() # gets all items and amounts
	var craftsToDisplay = []
	for i in range(inv[0].size()):
		var itemdata = ItemData.getItem(inv[0][i]) # item data
		var amount = inv[1][i] # amount in inventory rn
		for craft in itemdata.materialIn:
			if !craftsToDisplay.has(craft):
				craftsToDisplay.append(craft)
				
	if prevCraft != craftsToDisplay:
		clearIcons()
		timer.start()
		await timer.timeout
		
		for craft in craftsToDisplay:
			createIcon(craft,inv)
	else:
		
		for c in container.get_children():
			c.updateMe()
		
	prevCraft = craftsToDisplay
	
func createIcon(craftID,inv):
	var ins = iconScene.instantiate()
	ins.craftID = craftID
	ins.inv = inv
	ins.parent = self
	container.add_child(ins)

func clearIcons():
	for c in container.get_children():
		c.queue_free()

func setData(data):
	pass
