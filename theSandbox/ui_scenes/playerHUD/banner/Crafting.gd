extends Node2D

@onready var container = $ScrollContainer/GridContainer
@onready var iconScene = preload("res://ui_scenes/playerHUD/crafting/crafting_icon.tscn")
@onready var ingredientScene = preload("res://ui_scenes/playerHUD/crafting/crafting_ingredient_preview.tscn")

@onready var banner = get_parent().get_parent()

@onready var timer = $Timer

var prevCraft = []

var stationScan = []

var scanTick = 0

var showUncraftables = true

func _ready():
	PlayerData.updateInventory.connect(createCraftingIcons)

func createCraftingIcons():
	if !banner.invOpen:
		return
	if !timer.is_stopped():
		return
	
	stationScan = GlobalRef.player.scanForStations()
	
	var inv = PlayerData.getItemTotals() # gets all items and amounts
	var craftsToDisplay = []
	for i in range(inv[0].size()):
		var itemdata = ItemData.getItem(inv[0][i]) # item data
		#var amount = inv[1][i] # amount in inventory rn
		for craft in itemdata.materialIn:
			if !craftsToDisplay.has(craft):
				craftsToDisplay.append(craft)
				
	if prevCraft != craftsToDisplay:
		clearIcons()
		#timer.start()
		#await timer.timeout
		
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

func displayCraftingInfo(craftid):
	if craftid == null:
		$itemInfo.visible = false
		return
	
	var craftd = CraftData.getCraft(craftid)
	var itemdata = ItemData.getItem(craftd["crafts"])
	$itemInfo/itemName.text = itemdata.itemName
	
	
	for c in $itemInfo/ingHolder.get_children():
		c.queue_free()
		
	var i = 0
	for ing in craftd["ingredients"]:
		
		var item = ItemData.getItem(ing)
		var ins = ingredientScene.instantiate()
		ins.amount = craftd["ingAmounts"][i]
		ins.spr = item.texture
		ins.itemName = item.itemName
		
		ins.position.y = i * 16
		
		ins.has = PlayerData.checkForIngredient(ing,ins.amount)
		
		$itemInfo/ingHolder.add_child(ins)
		
		i += 1
	
	
	
	$itemInfo.visible = true

func _process(delta):
	if banner.invOpen:
		scanTick += 1
		
		if scanTick % 60 == 0:
			stationScan = GlobalRef.player.scanForStations()
			scanTick = 0

func updateUncraftableVis():
	for c in container.get_children():
		c.updateIfUncraftable()
