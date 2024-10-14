extends Node


func getChestLoot(planetType):
	var lootResource :PlanetType= PlanetTypeInfo.getData(planetType)
	if lootResource == null:
		return "2x1x0"
	
	var lootString :String= ""
	
	var rareItem:RollableItem = lootResource.rollWeights( lootResource.rareItems )
	var funItem:RollableItem = lootResource.rollWeights( lootResource.funItems )

	var rareAm = randi_range( rareItem.amountMin, rareItem.amountMax )
	lootString += str(rareItem.id) + "x" + str(rareAm) + "x0,"
	
	for i in range(4):
		var common = lootResource.rollWeights( lootResource.commonItems )
		var amount = randi_range( common.amountMin, common.amountMax )
		lootString += str(common.id) + "x" + str(amount) + "x" + str(i+1) + ","
	
	var funAm = randi_range( funItem.amountMin, funItem.amountMax )
	lootString += str(funItem.id) + "x" + str(funAm) + "x5,"
	
	print(lootString)
	return lootString
