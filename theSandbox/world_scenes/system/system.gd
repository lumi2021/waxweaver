extends Node2D

@onready var objectContainer = $Objects
@onready var cosmicBodyContainer = $CosmicBodies

@onready var planetScene = preload("res://world_scenes/planet/planet.tscn")

@export var rootPlanet := Node2D

var planets = []

var planetsShouldGenerate = true

var autosaveTicks :int= 0
var lastSave :float= Time.get_unix_time_from_system()

func _ready():
	planetsShouldGenerate = !Saving.has_save(Saving.loadedFile)
	
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
	
	# used for saving order
	planets.append(sun)
	planets.append(forestPlanet)
	planets.append(forestMoon)
	
	# halt
	if !planetsShouldGenerate:
		loadSaveFromFile()
	
	await get_tree().create_timer(0.1).timeout
	
	#Spawns player position
	if is_instance_valid(GlobalRef.player):
		GlobalRef.camera.map.map(self,cosmicBodyContainer.get_children())
	else:
		
		var player = load("res://object_scenes/player/player.tscn").instantiate()
		player.system = self
		objectContainer.add_child(player)
		
		var pee = forestPlanet.DATAC.findSpawnPosition(BlockData.theChunker.returnLookup())
		player.position = Vector2(pee) + forestPlanet.position
		player.attachToPlanet(forestPlanet)
		player.respawn()
	
		var children = cosmicBodyContainer.get_children()
		children.append(player)
		GlobalRef.camera.map.map(self,children)
		
		await get_tree().create_timer(0.1).timeout
		player.respawn()
		saveGameToFile()

func saveGameToFile():
	var gameData :Dictionary= {} # will hold all data
	var planetDictionary :Array = [] # will hold the data for planets
	var chestDictionary :Array = [] # will hold planet chest data
	
	for planet in planets: # parse over all planets
		var saveString :PackedStringArray= planet.DATAC.getSaveString()
		var hex :String= var_to_bytes(saveString).hex_encode() # compact string
		planetDictionary.append( hex )
		
		var chest = planet.chestDictionary
		var chestHex :String= var_to_bytes(chest).hex_encode() # compact string
		chestDictionary.append( chestHex )
	
	gameData["version"] = GlobalRef.version
	gameData["versionEra"] = 0 # 0:alpha, 1:release
	gameData["planets"] = planetDictionary
	gameData["chests"] = chestDictionary
	gameData["playerInventory"] = var_to_bytes(PlayerData.inventory).hex_encode()
	gameData["playerHealth"] = GlobalRef.player.healthComponent.health
	gameData["playtime"] = GlobalRef.globalTick
	gameData["worldname"] = Saving.worldName
	gameData["cheats"] = GlobalRef.cheatsEnabled
	if GlobalRef.playerSpawnPlanet != null:
		gameData["spawnPlanet"] = planets.find(GlobalRef.playerSpawnPlanet) # gets planet id
		gameData["spawnpoint"] = var_to_str(GlobalRef.playerSpawn)
	
	Saving.write_save(Saving.loadedFile,gameData)
	
	lastSave = Time.get_unix_time_from_system() # keep track of time elapsed

func loadSaveFromFile():
	var gameData = Saving.read_save( Saving.loadedFile )
	if gameData == null:
		printerr( "Failed to load save, save file doesn't exist." )
		return
	
	var planetDic :Array = gameData["planets"]
	var chestDic :Array = gameData["chests"]
	var id :int= 0
	for planet in planets: # parse over all planets
		
		# planet data
		var decoded :PackedByteArray = planetDic[id].hex_decode()
		var pldt :PackedStringArray = bytes_to_var(decoded)
		planet.DATAC.loadFromString(pldt[0],pldt[1],pldt[2],pldt[3],pldt[4])
		if planet == GlobalRef.currentPlanet:
			planet.forceChunkDrawUpdate()
			
		# chest data
		var chestDecoded :PackedByteArray = chestDic[id].hex_decode()
		var chstdt :Dictionary = bytes_to_var(chestDecoded)
		planet.chestDictionary = chstdt.duplicate()
		
		id += 1
	
	# inventory
	PlayerData.inventory = bytes_to_var(gameData["playerInventory"].hex_decode())
	PlayerData.emit_signal("updateInventory")
	PlayerData.emit_signal("armorUpdated")
	
	# spawnpoint
	if gameData.has("spawnpoint"):
		GlobalRef.playerSpawnPlanet = planets[ gameData["spawnPlanet"] ] # gets planet id
		GlobalRef.playerSpawn = str_to_var(gameData["spawnpoint"])
	
	#time
	GlobalRef.globalTick = gameData["playtime"]
	if gameData.has("worldname"):
		Saving.worldName = gameData["worldname"]
	
	# player health
	if gameData.has("playerHealth"):
		GlobalRef.savedHealth = gameData["playerHealth"]
	else:
		GlobalRef.savedHealth = 100
	
	# cheats
	GlobalRef.cheatsEnabled = gameData["cheats"]
		
func posToTile(pos):
	# just ensures anything emitted into the main system doesnt crash
	return null

func _exit_tree():
	
	$lightRenderViewport.world_2d = null
	$dropShadowViewport.world_2d = null
	
	saveGameToFile()

func _process(delta):
	autosaveTicks += 1
	if autosaveTicks > 10800: # every 3 minutes
		if GlobalRef.player.velocity.length() < 2.0: # make sure player is standing still
			Saving.autosave()
			autosaveTicks = 0
			print("Game autosaved!")
	
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused
		
		$PauseMenu.visible = get_tree().paused
		$PauseMenu/optionsMenu.hide()

