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
		
		var s = (randi() % 4)
		match s:
			0: newPlanet.SIZEINCHUNKS = 12
			1: newPlanet.SIZEINCHUNKS = 16
			2: newPlanet.SIZEINCHUNKS = 24
			3: newPlanet.SIZEINCHUNKS = 32
		
		var c = sqrt((newPlanet.SIZEINCHUNKS * 64) * (newPlanet.SIZEINCHUNKS * 64) * 2)
		var cPrevious = sqrt((lastPlanet.SIZEINCHUNKS * 64) * (lastPlanet.SIZEINCHUNKS * 64) * 2)
		var distance = ((c + cPrevious)/2) + 800 + (randi() % 2800)
		newPlanet.orbitDistance = distanceOverlap + distance
		
		newPlanet.orbitSpeed = 300000.0 / (distanceOverlap + distance)
		newPlanet.orbitPeriod = randf_range(0.0,PI * 2)
		
		distanceOverlap += distance
		
		
		cosmicBodyContainer.add_child(newPlanet)
		lastPlanet = newPlanet
	
	GlobalRef.player.map.map(self)

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
