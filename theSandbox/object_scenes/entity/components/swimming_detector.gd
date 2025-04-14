extends Node2D

@export var isEnemy :bool = true

var body = null
var wasInWater = false

var volume = 0.7

func _ready():
	if isEnemy:
		body = get_parent().planet
		volume = 0.32

func _process(delta):
	if !is_instance_valid(body):
		return # cancel if body invalid
	
	var tile = body.posToTile( body.to_local(global_position) )
	if tile == null:
		return # cancel if outside world boundary
	
	var waterLevel :float= abs(body.DATAC.getWaterData(tile.x,tile.y))
	var inWater :bool = waterLevel
	
	var detect = int(inWater) + int(wasInWater) 
	
	if detect % 2 != 0:
		var s :int= 1 - int(wasInWater)
		SoundManager.playSound("enemy/swim" + str(s),global_position,volume,0.2)
	wasInWater = inWater
