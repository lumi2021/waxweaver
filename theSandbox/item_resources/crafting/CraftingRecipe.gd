extends Resource
class_name CraftingRecipe

@export var itemToCraft :int = 2
@export var amountToCraft :int = 1

@export var ingredients :Array[CraftingIngredient] = []

@export_subgroup("Station")
@export var requiresStation :bool = true
enum stationEnum {FURNACE = 16, WORKBENCH = 20, GRILL = 46}
@export var station :stationEnum

var internalID = 0
