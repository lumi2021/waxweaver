extends Resource
class_name PlanetType

@export_category("Loot")
@export_group("Loot Chest")
@export var rareItems :Array[RollableItem] = []
@export var commonItems :Array[RollableItem] = []
@export var funItems :Array[RollableItem] = []
@export_group("Fishing")
@export var fish :Array[RollableItem] = []

@export_category("Enemy Spawning")

@export var surfaceDay:Array[EnemyRoll]
@export var surfaceNight:Array[EnemyRoll]
@export var underground:Array[EnemyRoll]
@export var water:Array[EnemyRoll]


func getEnemySpawn(context:int):
	match context:
		0:
			return rollWeights(surfaceDay)
		1:
			return rollWeights(surfaceNight)
		2:
			return rollWeights(underground)
		3:
			return rollWeights(water)

func rollWeights(objects:Array):
	
	
	var total = 0
	for i in range(objects.size()): # total all weights
		total += objects[i].weight
	
	var rand = randi() % total # randomly selects from 0 - weight total
	
	var cursor = 0
	for i in range(objects.size()):
		cursor += objects[i].weight
		if cursor > rand:
			return objects[i]
	print("roll didnt work")
	return objects[0]

func getFish():
	return rollWeights(fish)
