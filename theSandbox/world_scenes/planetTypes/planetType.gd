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

@export var desertDay:Array[EnemyRoll]
@export var desertNight:Array[EnemyRoll]
@export var desertUnderground:Array[EnemyRoll]

@export var snowyDay:Array[EnemyRoll]
@export var snowyNight:Array[EnemyRoll]
@export var snowyUnderground:Array[EnemyRoll]

@export var moss:Array[EnemyRoll]


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
		4:
			return rollWeights(desertDay)
		5:
			return rollWeights(desertNight)
		6:
			return rollWeights(desertUnderground)
		7:
			return rollWeights(snowyDay)
		8:
			return rollWeights(snowyNight)
		9:
			return rollWeights(snowyUnderground)
		10:
			return rollWeights(moss)

func rollWeights(objects:Array):
	
	if objects.size() == 0:
		var j = EnemyRoll.new()
		j.id == "butterfly"
		return j
	
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
