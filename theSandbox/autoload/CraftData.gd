extends Node

var longAssString = ""

func _ready():
	
	if !OS.has_feature("standalone"):
		initializeRecipies() # parses all files to create recipe dictionary
		# only runs in editor
		# need to run game twice to properly instantiate new recipies

func initializeRecipies():
	var i = 0
	var folder = "res://item_resources/crafting/recipies/"
	var dir = DirAccess.open(folder)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "": # search through each file in crafting recipies
			var r :CraftingRecipe = load( folder + file_name )
			longAssString += "load(\"" + folder + file_name + "\"),"
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	
	createScript()
	
func getRecipe(id:int) -> CraftingRecipe:
	return Recipies.recipies[id]

func createScript():
	var text = "extends Node\n"+"var recipies :Array[CraftingRecipe]=["+longAssString+"]"
	
	text += "\n\n\n"
	text += "func _ready():\n"
	text += "\tvar i:int=0\n"
	text += "\tfor r in recipies:\n"
	text += "\t\tr.internalID = i\n"
	text += "\t\tfor item in r.ingredients:\n"
	text += "\t\t\tItemData.data[item.ingredient].materialIn.append( i )\n"
	text += "\t\ti += 1\n"
	
	var file = FileAccess.open("res://autoload/Recipies.gd",FileAccess.WRITE)
	file.store_string(text)
