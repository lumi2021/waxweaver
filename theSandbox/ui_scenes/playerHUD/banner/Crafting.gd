extends Node2D

@onready var container = $ScrollContainer/GridContainer
@onready var recipeIconScene = preload("res://item_resources/crafting/scenes/crafting_slot.tscn")
@onready var ingredientScene = preload("res://ui_scenes/playerHUD/crafting/crafting_ingredient_preview.tscn")

@onready var banner = get_parent().get_parent()

var stationScan = []
var scanTick = 0
signal scannedStations

var oldRecipies :Array[int]= []

func _ready():
	PlayerData.updateInventory.connect(reloadCraftingRecipies)

func reloadCraftingRecipies():
	var newRecipies = PlayerData.parseRecipies()
	if oldRecipies == newRecipies:
		return # do nothing if available recipies havent changed
	
	clearOldIcons()
	
	for id in newRecipies:
		var ins = recipeIconScene.instantiate()
		ins.recipe = CraftData.getRecipe(id)
		ins.parent = self
		container.add_child( ins )
	
	oldRecipies = newRecipies
	
func clearOldIcons():
	for child in container.get_children():
		child.queue_free()


func displayCraftingInfo(recipe:CraftingRecipe):
	if recipe == null:
		$itemInfo.visible = false
		return
	
	var itemdata = ItemData.getItem(recipe.itemToCraft)
	$itemInfo/itemName.text = itemdata.itemName
	
	
	for c in $itemInfo/ingHolder.get_children():
		c.queue_free()
		
	var i = 0
	for ing in recipe.ingredients:
		
		var item = ItemData.getItem(ing.ingredient)
		var ins = ingredientScene.instantiate()
		ins.amount = ing.amount
		ins.spr = item.texture
		ins.itemName = item.itemName
		
		ins.position.y = i * 16
		
		ins.has = PlayerData.checkForIngredient(ing.ingredient,ing.amount)
		
		$itemInfo/ingHolder.add_child(ins)
		
		i += 1
	
	
	
	$itemInfo.visible = true

func _process(delta):
	if banner.invOpen:
		scanTick += 1
		
		if scanTick % 60 == 0:
			stationScan = GlobalRef.player.scanForStations()
			emit_signal("scannedStations")
			scanTick = 0
