extends Node2D

@onready var objectContainer = $Objects
@onready var cosmicBodyContainer = $CosmicBodies

@onready var planetScene = preload("res://world_scenes/planet/planet.tscn")

@export var rootPlanet := Node2D

func _ready():
	generateSystem()
	GlobalRef.system = self

func generateSystem():
	for planet in cosmicBodyContainer.get_children():
		planet.queue_free()
	
	#Create sun
	var sun = planetScene.instantiate()
	sun.planetType = "sun"
	sun.SIZEINCHUNKS = 8
	sun.system = self
	cosmicBodyContainer.add_child(sun)
	rootPlanet = sun
	
	var planetAmount = 4  #(randi() % 5) + 1
	var lastPlanet = sun
	var distanceOverlap = 0
	for i in range(planetAmount):
		
		var newPlanet = planetScene.instantiate()
		newPlanet.planetType = "forest"
		newPlanet.orbiting = sun
		newPlanet.system = self
		
		var s = 4 #(randi() % 5)
		match s:
			0: newPlanet.SIZEINCHUNKS = 32
			1: newPlanet.SIZEINCHUNKS = 32
			2: newPlanet.SIZEINCHUNKS = 48
			3: newPlanet.SIZEINCHUNKS = 48
			4: newPlanet.SIZEINCHUNKS = 64
		
		var c = sqrt((newPlanet.SIZEINCHUNKS * 64) * (newPlanet.SIZEINCHUNKS * 64) * 2)
		var cPrevious = sqrt((lastPlanet.SIZEINCHUNKS * 64) * (lastPlanet.SIZEINCHUNKS * 64) * 2)
		var distance = ((c + cPrevious)/2) + 2000 + (randi() % 2800)
		
		var shouldAddForMoon = 0
		var moon = null
		if randi() % 3 == 0:
			#generate moon
			moon = planetScene.instantiate()
			moon.planetType = "lunar"
			moon.orbiting = newPlanet
			moon.system = self
			moon.SIZEINCHUNKS = 8
			var m = sqrt((moon.SIZEINCHUNKS * 64) * (moon.SIZEINCHUNKS * 64) * 2) 
			
			moon.orbitDistance = (c + m * 2) + (randi() % 512)
			moon.orbitSpeed = 30000.0 / (c + m)
			moon.orbitPeriod = randf_range(0.0,PI * 2)
			
			shouldAddForMoon = (moon.orbitDistance * 2.0) + 2048
			
		
		elif distanceOverlap + distance + shouldAddForMoon > 49950 - newPlanet.SIZEINCHUNKS * 64:
			newPlanet.queue_free()
			if moon != null:
				moon.queue_free()
			break

		newPlanet.orbitDistance = distanceOverlap + distance + shouldAddForMoon
		newPlanet.orbitSpeed = 30000.0 / (distanceOverlap + distance)
		newPlanet.orbitPeriod = randf_range(0.0,PI * 2)
		
		distanceOverlap += distance + shouldAddForMoon
		
		
		cosmicBodyContainer.add_child(newPlanet)
		if moon != null:
			cosmicBodyContainer.add_child(moon)
		lastPlanet = newPlanet
	
	await get_tree().create_timer(0.25).timeout
	
	#Spawns player position
	if is_instance_valid(GlobalRef.player):
		GlobalRef.camera.map.map(self,cosmicBodyContainer.get_children())
	else:
		
		var player = load("res://object_scenes/player/player.tscn").instantiate()
		player.system = self
		objectContainer.add_child(player)
		
		var pee = lastPlanet.DATAC.findSpawnPosition()
		print(pee)
		player.position = Vector2(4,pee) + lastPlanet.position
		

		GlobalRef.camera.map.map(self,cosmicBodyContainer.get_children())
		
		player.attachToPlanet(lastPlanet)

#func reparentToPlanet(object,planet):
	#print(object)
	#print(planet)
	#if !objectContainer.get_children().has(object):
		#return
	#
	#if object == GlobalRef.player:
		#object.planet = planet
	#object.reparent(planet.entityContainer)
#
#
#func dumpObjectToSpace(object):
	#object.reparent(objectContainer)
	#if object == GlobalRef.player:
		#object.planet = null
		#resetObjectPositions()
#
#func resetObjectPositions():
	#var rootPosition = rootPlanet.position
	#for planet in cosmicBodyContainer.get_children():
		#planet.position -= rootPosition
	#for object in objectContainer.get_children():
		#object.position -= rootPosition
