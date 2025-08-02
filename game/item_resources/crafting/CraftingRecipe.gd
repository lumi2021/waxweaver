extends Resource
class_name CraftingRecipe

@export var itemToCraft :int = 2
@export var amountToCraft :int = 1

@export var ingredients :Array[CraftingIngredient] = []

@export var requiresStation :bool = true
enum stationEnum {NONE = 0, FURNACE = 16, WORKBENCH = 20, GRILL = 46, MAGICINFUSER = 78, SOLDERINGIRON = 94, TRINKETSTATION = 129}
@export var station :stationEnum

enum recipieTypeEnum {BLOCKS,WALLS,TOOL,EQUIP,FOOD,FURNITURE,ELECTRICAL}
@export var recipieType :recipieTypeEnum

var internalID = 0
