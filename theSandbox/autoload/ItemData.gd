extends Node

var data = {
	-1:null,
	# block items
	0:load("res://items/blocks/natural/StoneItem.tres"),
	2:load("res://items/blocks/natural/StoneItem.tres"),
	3:load("res://items/blocks/natural/DirtItem.tres"),
	7:load("res://items/blocks/foliage/SaplingItem.tres"),
	13:load("res://items/blocks/building/WoodItem.tres"),
	-13:load("res://items/walls/WoodWallItem.tres"),
	14:load("res://items/blocks/natural/SandItem.tres"),
	15:load("res://items/torches/TorchItem.tres"),
	16:load("res://items/blocks/furniture/stations/Furnace.tres"),
	18:load("res://items/blocks/ores/CopperOre.tres"),
	20:load("res://items/blocks/furniture/stations/WorkBench.tres"),
	21:load("res://items/blocks/building/GlassItem.tres"),
	-21:load("res://items/walls/GlassWallItem.tres"),
	24:load("res://items/blocks/ores/GoldOre.tres"),
	25:load("res://items/blocks/furniture/other/Ladder.tres"),
	26:load("res://items/blocks/foliage/flowers/LilyItem.tres"),
	
	# item ids
	3000:load("res://items/tools/flimsy/FlimsySword.tres"), # flimsy tools
	3001:load("res://items/tools/flimsy/FlimsyPickaxe.tres"),
	3002:load("res://items/tools/flimsy/FlimsyHammer.tres"),
	
	3003:load("res://items/material/Wax.tres"),
	3004:load("res://items/material/bars/CopperBar.tres"),
	3005:load("res://items/material/bars/GoldBar.tres"),
	
	3006:load("res://items/tools/copper/CopperSword.tres"), # copper tools
	3007:load("res://items/tools/copper/CopperPickaxe.tres"),
	
	3008:load("res://items/tools/golden/GoldenSword.tres"), # golden tools
	3009:load("res://items/tools/golden/GoldenPickaxe.tres"),
	
	
	# chairs 6000 - 6199
	6000:load("res://items/blocks/furniture/chairs/WoodenChair.tres"),
	6001:load("res://items/blocks/furniture/chairs/Toilet.tres"),
	
	# doors 6200 - 6399
	6200:load("res://items/blocks/furniture/doors/WoodDoor.tres"),
	6201:load("res://items/tools/golden/GoldenPickaxe.tres"),
}

var heldItemAnims = {
	"itemSwing" : load("res://item_resources/item_held_scenes/item_swing.tscn"),
}

func matchItemAnimation(id):
	var d = getItem(id)
	if d is ItemDamage:
		return "itemSwing"
	
	return null

func getItem(id):
	if data.has(id):
		return data[id]
	return data[0]

func itemExists(id):
	return data.has(id)

func getItemName(id):
	var data = getItem(id)
	return data.itemName
		

