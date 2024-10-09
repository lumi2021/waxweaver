extends Resource
class_name Loot

@export_enum("random", "weighted", "all") var rollType: int = 0
@export var rollCount :int = 1

@export var table :Array[RollableItem] = []

func getLoot() -> Array[LootItem]:
	
	var itemArray :Array[LootItem] = []
	
	for i in range(rollCount):
		match rollType:
			0:
				itemArray.append(rollRand())
			1:
				itemArray.append(rollWeight())
	
	return itemArray

func rollWeight() ->LootItem:
	var item :LootItem = LootItem.new()
	var totalWeight := 0
	for rolleditem in table:
		totalWeight += rolleditem.weight
	
	var rand = randi() % totalWeight # randomly selects from 0 - weight total
	
	var cursor = 0
	for rolleditem in table:
		cursor += rolleditem.weight
		if cursor > rand:
			
			item.id = rolleditem.id
			item.amount = rollItemAmount(rolleditem)
			
			return item
	print("roll didnt work")
	return item

func rollRand() ->LootItem:
	var r = randi() % table.size()
	var item :LootItem = LootItem.new()
	item.id = table[r].id
	item.amount = rollItemAmount(table[r])
	return item

func rollItemAmount(item:RollableItem) -> int:
	return randi_range(item.amountMin ,item.amountMax  )
