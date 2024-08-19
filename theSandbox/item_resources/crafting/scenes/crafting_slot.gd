extends NinePatchRect

@onready var sprite = $sprite
@onready var amountLabel = $amount

var recipe :CraftingRecipe

var craftableTexture = preload( "res://ui_scenes/playerHUD/crafting/craftingIcon.png" )
var uncraftableTexture = preload( "res://ui_scenes/playerHUD/crafting/cantCraft.png" )

var parent :Node2D= null

var isCraftable = false

func _ready():
	displayRecipe()
	updateCraftability()
	PlayerData.updateInventory.connect(updateCraftability)
	parent.scannedStations.connect(changeVisibility)

func displayRecipe():
	var itemID :int= recipe.itemToCraft
	var amount :int= recipe.amountToCraft
	
	sprite.texture = ItemData.getItemTexture(itemID)
	amountLabel.text = str( amount )

func updateCraftability():
	var isCraftable = PlayerData.checkIfCraftable(recipe)
	displayCanCraft( isCraftable )

func displayCanCraft(canCraft):
	
	changeVisibility()
	
	if canCraft:
		texture = craftableTexture
	else:
		texture = uncraftableTexture
	
	isCraftable = canCraft

func changeVisibility():
	#print(checkForStation())
	visible = checkForStation()

func checkForStation():
	if recipe.requiresStation:
		return parent.stationScan.has( recipe.station )

	return true


func _on_craft_button_pressed():
	if isCraftable:
		var canCraftAgain = PlayerData.craftItem(recipe)
		displayCanCraft(canCraftAgain)

func _on_craft_button_mouse_entered():
	parent.displayCraftingInfo(recipe)


func _on_craft_button_mouse_exited():
	parent.displayCraftingInfo(null)
