extends Node2D

@onready var objectContainer = $Objects
@onready var cosmicBodyContainer = $CosmicBodies

@onready var planetScene = preload("res://world_scenes/planet/planet.tscn")

@export var rootPlanet := Node2D

func _ready():
	generateNewSystem()
	GlobalRef.system = self
	
	$lightRenderViewport.world_2d = get_tree().root.get_viewport().world_2d
	$dropShadowViewport.world_2d = get_tree().root.get_viewport().world_2d
	GlobalRef.lightRenderVP = $lightRenderViewport
	GlobalRef.dropShadowRenderVP = $dropShadowViewport
	
	

func generateNewSystem():
	for planet in cosmicBodyContainer.get_children():
		planet.queue_free()
	
	#Create sun
	var sun = planetScene.instantiate()
	sun.planetType = "sun"
	sun.SIZEINCHUNKS = 8
	sun.system = self
	cosmicBodyContainer.add_child(sun)
	rootPlanet = sun
	
	#  create Forest
	var forestPlanet = planetScene.instantiate()
	forestPlanet.planetType = "forest"
	forestPlanet.orbiting = sun
	forestPlanet.system = self
	forestPlanet.SIZEINCHUNKS = 96
	forestPlanet.orbitDistance = 36000.0
	forestPlanet.orbitSpeed = 3.0
	forestPlanet.orbitPeriod = randf_range(0.0,PI * 2) # where along the rotation is it
	
	cosmicBodyContainer.add_child(forestPlanet)
	
	#  create moon
	var forestMoon = planetScene.instantiate()
	forestMoon.planetType = "lunar"
	forestMoon.orbiting = forestPlanet
	forestMoon.system = self
	forestMoon.SIZEINCHUNKS = 32
	forestMoon.orbitDistance = 8000.0
	forestMoon.orbitSpeed = 50.0
	forestMoon.orbitPeriod = randf_range(0.0,PI * 2) # where along the rotation is it
	
	cosmicBodyContainer.add_child(forestMoon)
	
	#  create arid planet
	#var aridPlanet = planetScene.instantiate()
	#aridPlanet.planetType = "arid"
	#aridPlanet.orbiting = sun
	#aridPlanet.system = self
	#aridPlanet.SIZEINCHUNKS = 64
	#aridPlanet.orbitDistance = 15000.0
	#aridPlanet.orbitSpeed = 4.0
	#aridPlanet.orbitPeriod = randf_range(0.0,PI * 2) # where along the rotation is it
	
	#cosmicBodyContainer.add_child(aridPlanet)
	
	# halt
	await get_tree().create_timer(0.1).timeout
	
	#Spawns player position
	if is_instance_valid(GlobalRef.player):
		GlobalRef.camera.map.map(self,cosmicBodyContainer.get_children())
	else:
		
		var player = load("res://object_scenes/player/player.tscn").instantiate()
		player.system = self
		objectContainer.add_child(player)
		
		var pee = forestPlanet.DATAC.findSpawnPosition()
		player.position = Vector2(4,pee) + forestPlanet.position
		

		GlobalRef.camera.map.map(self,cosmicBodyContainer.get_children())
		
		player.attachToPlanet(forestPlanet)

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

func posToTile(pos):
	# just ensures anything emitted into the main system doesnt crash
	return null
