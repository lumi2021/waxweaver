extends Node

var data = {
	-1:null,
	0:load("res://item_resources/items/tool_items/DebugPickaxe.tres"),
	1:load("res://item_resources/items/tool_items/PickaxeStone.tres"),
	
	2:load("res://item_resources/items/block_items/StoneItem.tres"),
	3:load("res://item_resources/items/block_items/DirtItem.tres"),
	7:load("res://item_resources/items/block_items/SaplingItem.tres"),
	13:load("res://item_resources/items/block_items/WoodItem.tres"),
	-13:load("res://item_resources/items/wall_items/WoodWallItem.tres"),
	14:load("res://item_resources/items/block_items/SandItem.tres"),
	
	1000:load("res://item_resources/items/tool_items/HammerStone.tres"),
}

func getItem(id):
	if data.has(id):
		return data[id]
	return data[0]
