extends Node

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

# day cycle
var dayLength :int= 9000
var currentTime :float= 0 # 0.0 - 1.0
var daylightMult :float = 1.0

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
