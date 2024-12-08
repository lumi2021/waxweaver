extends Node

########### GAME INFO #################
var version :float = 20


#######################################

var player : Player = null
var camera = null
var system  = null
var lightmap = null
var hotbar = null
var lightRenderVP :SubViewport= null
var dropShadowRenderVP:SubViewport = null

var currentPlanet = null

var gravityConstant : float = 2000

var fastTick : float = 0.0
var globalTick : int = 0

var playerSide = 0 # 0 : facing left, 1 : facing right

var chatIsOpen = false
var playerCanUseItem = true

var playerSpawn = null
var playerSpawnPlanet = null
var savedHealth = 100

# day cycle
var dayLength :int= 9000
var currentTime :float= 0 # 0.0 - 1.0
var daylightMult :float = 1.0

var cheatsEnabled :bool= false

func clearEverything():
	player = null
	camera = null
	system  = null
	lightmap = null
	hotbar = null
	lightRenderVP = null
	dropShadowRenderVP = null
	currentPlanet = null
	gravityConstant = 2000
	fastTick = 0.0
	globalTick = 0
	playerSide = 0
	chatIsOpen = false
	playerCanUseItem = true
	playerSpawn = null
	playerSpawnPlanet = null
	dayLength = 9000
	currentTime = 0
	daylightMult = 1.0

func _process(delta):
	currentTime = (globalTick % dayLength) / float(dayLength)
	
	var wave = sin( ( currentTime * PI ) / 0.5 ) + 0.5
	daylightMult = clamp( wave,0.0,1.0 )
	
	
func isNight():
	return currentTime > 0.55

func _physics_process(delta):
	fastTick += 1
	if fastTick >= 4:
		globalTick += 1
		fastTick = 0

func sendChat(text:String,color:Color=Color.WHITE):
	if is_instance_valid(hotbar):
		hotbar.printIntoChat(text,color)

func sendError(text:String):
	if is_instance_valid(hotbar):
		hotbar.printIntoChat(text,Color.RED)
