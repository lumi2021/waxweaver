extends Node2D

@onready var itemScanner = $itemScanner

var chestPos :Vector2 = Vector2.ZERO
var planet :Planet

func _ready():
	await Engine.get_main_loop().physics_frame # wait two frames so collider can update
	await Engine.get_main_loop().physics_frame
	
	var items :Array= itemScanner.get_overlapping_bodies()
	# this should only be ground items
	
	for item in items:
		if item.pickedByHopper:
			continue
		var itemsLeft :int= addItemToChest(item.itemID,item.amount)
		item.pickedByHopper = true
		if itemsLeft == 0:
			item.queue_free()
			continue
		item.amount = itemsLeft
		item.determineAmount()
	
	queue_free()

func addItemToChest(id,amount) -> int: # return int is how many items left over
	
	if !planet.chestDictionary.has(chestPos):
		var gen = PlayerData.saveChestFromArray( PlayerData.generateEmptyChest() )
		planet.chestDictionary[chestPos] = gen
		# generates empty chest if chest hasn't yet been opened
	
	var chestString = planet.chestDictionary[chestPos]
	var chestData :Array= PlayerData.loadChestString(chestString)
				
	if PlayerData.currentSelectedChest == chestPos:
		PlayerData.closeChest()
		
	var itemsLeftToAdd :int= amount
	var stackSize :int = ItemData.getItem(id).maxStackSize
	
	for i in range(25):
		
		if itemsLeftToAdd <= 0:
			break
		
		if chestData[i][0] == id: # item is same item, attempt to stack
			var currentAmount = chestData[i][1]
			var total = currentAmount + itemsLeftToAdd
			if total <= stackSize:
				chestData[i][1] = total
				itemsLeftToAdd = 0
				break
			else:
				itemsLeftToAdd = total - stackSize
				chestData[i][1] = stackSize
				continue
		elif chestData[i][0] == -1: # empty slot
			var total = itemsLeftToAdd
			chestData[i][0] = id
			if total <= stackSize:
				chestData[i][1] = total
				itemsLeftToAdd = 0
				break
			else:
				itemsLeftToAdd = total - stackSize
				chestData[i][1] = stackSize
				continue
		elif chestData[i][0] != id: # item is different item, skip
			continue
	
	var newString = PlayerData.saveChestFromArray(chestData)
	planet.chestDictionary[Vector2(chestPos)] = newString
	
	return itemsLeftToAdd
