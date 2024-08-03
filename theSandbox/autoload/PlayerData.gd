extends Node

## HEALTH ##
var maxHealth :int= 100
var currentHealth :int= 100
signal updateHealth

## MOVEMENT ##
var speed = 100.0


## INVENTORY ##
# [ITEMID,COUNT]
var inventory = {} #0-39 inventory, 40-42 armor, 43-48 acces, 49 held, 50 - 52 vanity
signal updateInventory
signal onlyUpdateCraft
signal selectedSlotChanged
signal armorUpdated
var selectedSlot = 0

func _ready():
	initializeInventory()

func initializeInventory():
	for i in range(53):
		inventory[i] = [-1,-1]

func addItem(itemID,amount):
	
	var itemCountLeft = amount
	
	var itemData = ItemData.data[itemID]
	var itemMax = itemData.maxStackSize
	for slot in inventoryHasItem(itemID):
		var add = inventory[slot][1] + itemCountLeft
		if add > itemMax:
			itemCountLeft -= (itemMax - inventory[slot][1])
			inventory[slot][1] = itemMax
		else:
			inventory[slot][1] += itemCountLeft
			itemCountLeft = 0
			emit_signal("updateInventory")
			emit_signal("onlyUpdateCraft")
			return 0
	
	var emptySlot = findEmptySlot()
	if emptySlot == null:
		return itemCountLeft
	
	if itemCountLeft > itemMax:
		while itemCountLeft > itemMax:
			inventory[emptySlot] = [itemID,itemMax]
			itemCountLeft -= itemMax
			emptySlot = findEmptySlot()
			if emptySlot == null:
				return itemCountLeft
	
	inventory[emptySlot] = [itemID,itemCountLeft]
	
	emit_signal("updateInventory")
	emit_signal("onlyUpdateCraft")
	return 0
	

func findEmptySlot():
	for i in range(40):
		if inventory[i][0] == -1:
			return i
	return null

func inventoryHasItem(itemID):
	var slots = []
	for i in range(50):
		if inventory[i][0] == itemID:
			slots.append(i)
	return slots

func swapItem(slot1,slot2):
	
	var points = 0
	print(slot1)
	match slot1:
		40: #helmet
			points += int(ItemData.getItem(inventory[slot1][0]) is ItemArmorHelmet)  * 3
			points += int(ItemData.getItem(inventory[slot2][0]) is ItemArmorHelmet) * 3
		41: #chest
			points += int(ItemData.getItem(inventory[slot1][0]) is ItemArmorChest) * 3
			points += int(ItemData.getItem(inventory[slot2][0]) is ItemArmorChest) * 3
		42: #legs
			points += int(ItemData.getItem(inventory[slot1][0]) is ItemArmorLegs) * 3
			points += int(ItemData.getItem(inventory[slot2][0]) is ItemArmorLegs) * 3
		50: #vanity helmet
			points += int(ItemData.getItem(inventory[slot1][0]) is ItemArmorHelmet)  * 3
			points += int(ItemData.getItem(inventory[slot2][0]) is ItemArmorHelmet) * 3
		51: #vanity chest
			points += int(ItemData.getItem(inventory[slot1][0]) is ItemArmorChest) * 3
			points += int(ItemData.getItem(inventory[slot2][0]) is ItemArmorChest) * 3
		52: #vanity legs
			points += int(ItemData.getItem(inventory[slot1][0]) is ItemArmorLegs) * 3
			points += int(ItemData.getItem(inventory[slot2][0]) is ItemArmorLegs) * 3
		
		
		_: # every other slot
			points += 2
	
	if points <= 0:
		return
	
	
	var carry = inventory[slot1].duplicate()
	inventory[slot1] = inventory[slot2]
	inventory[slot2] = carry
	
	emit_signal("updateInventory")
	emit_signal("onlyUpdateCraft")
	if points > 2:
		emit_signal("armorUpdated")
	

func getSelectedItemData():
	return ItemData.data[inventory[selectedSlot][0]]

func getSelectedItemID():
	return inventory[selectedSlot][0]

func consumeSelected():
	inventory[selectedSlot][1] -= 1
	if inventory[selectedSlot][1] <= 0:
		inventory[selectedSlot] = [-1,-1]
	emit_signal("updateInventory")
	emit_signal("onlyUpdateCraft")

func getItemTotals():
	var items = []
	var amounts = []
	for i in inventory:
		if inventory[i][0] == -1: continue
		if items.has(inventory[i][0]):
			amounts[items.find(inventory[i][0])] += inventory[i][1]
		else:
			items.append(inventory[i][0])
			amounts.append(inventory[i][1])
	return [items,amounts]

func consumeItems(items:Array,amounts:Array):
	for i in range(items.size()):
		consumeFromSlots(checkForEnoughItems(items[i],amounts[i]),amounts[i])

func checkForEnoughItems(itemID,amount):
	var foundAmount = 0
	var slots = []
	for i in range(49):
		if inventory[i][0] == itemID:
			foundAmount += inventory[i][1]
			slots.append(i)
		if foundAmount >= amount:
			return slots
	return slots

func checkForItemAmount(itemID):
	var foundAmount = 0
	for i in range(49):
		if inventory[i][0] == itemID:
			foundAmount += inventory[i][1]
	return foundAmount

func consumeFromSlots(slots:Array,amount:int):
	var amountLeft = amount
	for i in slots:
		if inventory[i][1] > amountLeft:
			inventory[i][1] -= amountLeft
			return
		amountLeft -= inventory[i][1]
		inventory[i] = [-1,-1]

func craftItem(craftData):
	if inventory[49][0] != -1 and inventory[49][0] != craftData["crafts"]:
		return
	
	var maxStack = ItemData.getItem(craftData["crafts"]).maxStackSize
	if inventory[49][1] + craftData["amount"] > maxStack:
		return
		
	consumeItems(craftData["ingredients"],craftData["ingAmounts"])
	if inventory[49][0] == -1:
		inventory[49] = [ craftData["crafts"],craftData["amount"] ]
	else:
		if inventory[49][1] + craftData["amount"] <= maxStack:
			inventory[49][1] += craftData["amount"]
	emit_signal("updateInventory")
	
	for i in craftData["ingredients"].size():
		if checkForItemAmount(craftData["ingredients"][i]) < craftData["ingAmounts"][i]:
			return false # can not craft again
	
	return true # can craft again

func sendHealthUpdate(newHealth,newMax):
	maxHealth = newMax
	currentHealth = newHealth
	emit_signal("updateHealth")

func selectSlot(newSlot):
	selectedSlot = newSlot
	emit_signal("selectedSlotChanged")

func checkForIngredient(itemID,amount):
	var foundAmount = 0
	var slots = []
	for i in range(49):
		if inventory[i][0] == itemID:
			foundAmount += inventory[i][1]
			slots.append(i)
		if foundAmount >= amount:
			return true
	return false

func getSlotItemData(slot:int):
	return ItemData.data[inventory[slot][0]]
