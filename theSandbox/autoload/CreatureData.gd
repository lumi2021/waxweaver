extends Node

var creatureAmount = 0
var creatureLimit = 50

# this shit needs to be MADE BETTER !!!!!!!!!!!!!!!!!!!!!!!!

var spawnDelayTick = 0
var spawnDelayThreshold = 100

func _physics_process(delta):
	if GlobalRef.currentPlanet == null:
		return
	
	var planet = GlobalRef.currentPlanet
	
	if creatureAmount >= creatureLimit:
		return
	
	spawnDelayTick += 1
	if spawnDelayTick > spawnDelayThreshold:
		for attempt in range(50):
			var randomTile = pickRandomSpot(planet)
			
			if planet.DATAC.getTileData(randomTile.x,randomTile.y) > 1:
				continue # if random spot is in wall, fail and try again
			
			var floorTile = scanValid(planet,randomTile)
			if floorTile == Vector2i(-10,-10):
				continue # fail if couldn't find valid floor
			
			spawnEnemy(planet,floorTile,determineContext(floorTile,planet))
			spawnDelayTick = 0
			return
		spawnDelayTick = 0

func determineContext(tile,planet):
	if abs(planet.DATAC.getWaterData(tile.x,tile.y)) > 0.5:
		return 3 # is water
	
	if planet.DATAC.getTileData(tile.x,tile.y) == 1:
		return 2 # is cave
	
	if GlobalRef.isNight():
		return 1 # surface night
	return 0 #surface day

func scanValid(planet,tile):
	var floorScan = planet.DATAC.findFloor(tile.x,tile.y,BlockData.theChunker.returnLookup())
	if floorScan == Vector2i(-10,-10):
		return Vector2i(-10,-10)
	
	# check if floor is in non-visible and real chunk
	var chunkkey = Vector2(int(floorScan.x)/8,int(floorScan.y)/8)
	if !planet.chunkDictionary.has(chunkkey):
		return Vector2i(-10,-10) # fail if chunk is unrendered
	
	if isTileOnScreen(floorScan,planet):
		return Vector2i(-10,-10) # fail because tile on screen
	
	return floorScan
	

func spawnEnemy(planet,tile,context):
	
	var data = PlanetTypeInfo.getData(planet.planetType)
	var string = data.getEnemySpawn(context)
	var ins = load("res://object_scenes/entity/enemy_scenes/" +string).instantiate()
	ins.position = planet.tileToPos(Vector2(tile))
	creatureAmount += 5
	ins.editor_description = str(5)
	planet.entityContainer.add_child(ins)


func spawnEnemyFromFile(file:String,tile:Vector2,planet):
	pass

func creatureDeleted(creature):
	creatureAmount -= int(creature.editor_description)
	creatureAmount = max(creatureAmount,0)

func isTileOnScreen(tile,planet):
	
	var playerTile = planet.posToTile(GlobalRef.player.position)+ Vector2(0,-3).rotated( PI * GlobalRef.player.rotated )
	
	var xRange = abs(tile.x - playerTile.x)
	var yRange = abs(tile.y - playerTile.y)
	
	var rangeMin = Vector2(26,20).rotated( PI * GlobalRef.player.rotated )
	
	if xRange <= abs(rangeMin.x) and yRange <= abs(rangeMin.y):
		return true


	return false
	
func pickRandomSpot(planet):
	var playerTile = planet.posToTile(GlobalRef.player.position) + Vector2(0,-24).rotated( PI * GlobalRef.player.rotated )
	
	
	var range = Vector2(36,24).rotated( PI * GlobalRef.player.rotated )
	
	var tileX = randi_range(-abs(range.x),abs(range.x))# * ((2 * (randi() % 2)) - 1)
	var tileY = randi_range(-abs(range.y),abs(range.y))# * ((2 * (randi() % 2)) - 1)

	return Vector2(tileX + playerTile.x,tileY + playerTile.y)
