extends Node

var data = {
	-1:null,
	# block items
	2:load("res://items/blocks/natural/StoneItem.tres"),
	3:load("res://items/blocks/natural/DirtItem.tres"),
	7:load("res://items/blocks/foliage/SaplingItem.tres"),
	13:load("res://items/blocks/building/WoodItem.tres"),
	-13:load("res://items/walls/WoodWallItem.tres"),
	14:load("res://items/blocks/natural/SandItem.tres"),
	15:load("res://items/torches/TorchItem.tres"),
	16:load("res://items/blocks/TestTable.tres"),
	
	18:load("res://items/blocks/ores/CopperOre.tres"),
	
	
	# item ids
	3000:load("res://items/tools/FlimsySword.tres"),
	3001:load("res://items/tools/FlimsyPickaxe.tres"),
	3002:load("res://items/tools/FlimsyHammer.tres"),
	3003:load("res://items/material/Wax.tres"),
	
	
	# chairs 6000 - 6199
	6000:load("res://items/blocks/furniture/chairs/WoodenChair.tres"),
	6001:load("res://items/blocks/furniture/chairs/Toilet.tres"),
	
	# doors 6200 - 6399
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
