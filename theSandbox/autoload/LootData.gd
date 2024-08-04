extends Node


func getChestLoot(planetType):
	var lootResource = null
	match planetType:
		"forest":
			lootResource = load("res://item_resources/chestLootTables/ForestLoot.tres")
	
	if lootResource == null:
		return "2x1x0"
	
	var lootString :String= ""
	
	var rarePool = lootResource.rareItems
	var commonPool = lootResource.commonItems
	var cMin = lootResource.commonMinimum
	var cMax = lootResource.commonMaximum
	
	var r = randi() % rarePool.size()
	lootString = lootString + str(rarePool[r]) + "x1x0,"
	
	for i in range(4):
		var c = randi() % commonPool.size()
		var amount = randi_range(cMin[c],cMax[c])
		lootString = lootString + str(commonPool[c]) + "x" + str(amount) + "x" + str(i+1) + ","
	
	print(lootString)
	return lootString
