extends Resource
class_name PlanetType

@export_category("Loot")
@export_group("Loot Chest")
@export var rareItems :Array[int] = []
@export var commonItems :Array[int] = []
@export var commonMinimum :Array[int] = []
@export var commonMaximum :Array[int] = []
@export_group("Fishing")
@export var fish :Array[int] = []
@export var fishWeight :Array[int] = []

@export_category("Enemy Spawning")

@export_group("Surface Day")
@export var surfaceDay :Array[String] = []
@export var surfaceDayWeight :Array[int] = []
@export_group("Surface Night")
@export var surfaceNight :Array[String] = []
@export var surfaceNightWeight :Array[int] = []
@export_group("Underground")
@export var underground :Array[String] = []
@export var undergroundWeight :Array[int] = []
@export_group("Water")
@export var water :Array[String] = []
@export var waterWeight :Array[int] = []


func getEnemySpawn(context:int):
	match context:
		0:
			return rollWeights(surfaceDay,surfaceDayWeight)
		1:
			return rollWeights(surfaceNight,surfaceNightWeight)
		2:
			return rollWeights(underground,undergroundWeight)
		3:
			return rollWeights(water,waterWeight)

func rollWeights(objects,weights:Array[int]):
	
	if objects.size() != weights.size():
		printerr("EPIC FAIL: OBJECTS AND WEIGHTS ARE UNALIGNED! FAILED ROLL")
		return objects[0]
	
	var total = 0
	for weight in weights: # total all weights
		total += weight
	
	var rand = randi() % total # randomly selects from 0 - weight total
	
	var cursor = 0
	for i in range(weights.size()):
		cursor += weights[i]
		if cursor >= rand:
			return objects[i]
	return objects[0]
