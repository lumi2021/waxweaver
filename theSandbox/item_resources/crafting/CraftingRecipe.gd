extends Resource
class_name CraftingRecipe

@export var itemToCraft :int = 2
@export var amountToCraft :int = 1

@export var ingredients :Array[CraftingIngredient] = []

@export var requiresStation :bool = true
enum stationEnum {NONE = 0, FURNACE = 16, WORKBENCH = 20, GRILL = 46, MAGICINFUSER = 78}
@export var station :stationEnum

var internalID = 0
