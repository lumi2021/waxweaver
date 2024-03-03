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
	
	var planetAmount = (randi() % 5) + 1
	var lastPlanet = sun
	var distanceOverlap = 0
	for i in range(planetAmount):
		
		var newPlanet = planetScene.instantiate()
		newPlanet.planetType = "forest"
		newPlanet.orbiting = sun
		newPlanet.system = self
		
		var s = (randi() % 5)
		match s:
			0: newPlanet.SIZEINCHUNKS = 16
			1: newPlanet.SIZEINCHUNKS = 24
			2: newPlanet.SIZEINCHUNKS = 32
			3: newPlanet.SIZEINCHUNKS = 48
			4: newPlanet.SIZEINCHUNKS = 64
		
		var c = sqrt((newPlanet.SIZEINCHUNKS * 64) * (newPlanet.SIZEINCHUNKS * 64) * 2)
		var cPrevious = sqrt((lastPlanet.SIZEINCHUNKS * 64) * (lastPlanet.SIZEINCHUNKS * 64) * 2)
		var distance = ((c + cPrevious)/2) + 3000 + (randi() % 2800)
		
		var shouldAddForMoon = 0
		if randi() % 3 == 0:
			#generate moon
			var moon = planetScene.instantiate()
			moon.planetType = "lunar"
			moon.orbiting = newPlanet
			moon.system = self
			moon.SIZEINCHUNKS = 8
			var m = sqrt((moon.SIZEINCHUNKS * 64) * (moon.SIZEINCHUNKS * 64) * 2) 
			
			moon.orbitDistance = (c + m * 2) + (randi() % 512)
			moon.orbitSpeed = 30000.0 / (c + m)
			moon.orbitPeriod = randf_range(0.0,PI * 2)
			cosmicBodyContainer.add_child(moon)
			
			shouldAddForMoon = (moon.orbitDistance * 2.0) + 1024
		
		
		newPlanet.orbitDistance = distanceOverlap + distance + shouldAddForMoon
		newPlanet.orbitSpeed = 30000.0 / (distanceOverlap + distance)
		newPlanet.orbitPeriod = randf_range(0.0,PI * 2)
		
		distanceOverlap += distance + shouldAddForMoon
		
		
		cosmicBodyContainer.add_child(newPlanet)
		lastPlanet = newPlanet
	
	await get_tree().create_timer(0.5).timeout
	GlobalRef.player.map.map(self,cosmicBodyContainer.get_children())

func reparentToPlanet(object,planet):
	print(object)
	print(planet)
	if !objectContainer.get_children().has(object):
		return
	
	if object == GlobalRef.player:
		object.planet = planet
	object.reparent(planet.entityContainer)


func dumpObjectToSpace(object):
	object.reparent(objectContainer)
	if object == GlobalRef.player:
		object.planet = null
		resetObjectPositions()

func resetObjectPositions():
	var rootPosition = rootPlanet.position
	for planet in cosmicBodyContainer.get_children():
		planet.position -= rootPosition
	for object in objectContainer.get_children():
		object.position -= rootPosition
