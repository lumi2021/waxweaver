extends Node

var creatureAmount = 0
var creatureLimit = 10

# this shit needs to be MADE BETTER !!!!!!!!!!!!!!!!!!!!!!!!

func creatureDeleted(creature):
	creatureAmount -= int(creature.editor_description)
	creatureAmount = max(creatureAmount,0)

func attemptSpawnEnemy(planet,tile:Vector2,blockID:int,dir:int):
	
	if creatureAmount >= creatureLimit:
		return
	
	var bro = tile + Vector2(0,1).rotated((PI/2)*dir)
	if planet.getTileData(bro.x,bro.y) > 1:
		var ins = load("res://object_scenes/entity/enemy.tscn").instantiate()
		ins.position = planet.get_parent().tileToPos(tile)
		creatureAmount += 1
		ins.editor_description = str(1)
		planet.get_parent().entityContainer.add_child(ins)
		#print("GOOBER SPAWNED AT : " + str(tile))

func spawnEnemyFromFile(file:String,tile:Vector2,planet):
	pass

func _process(delta):
	print(creatureAmount)
