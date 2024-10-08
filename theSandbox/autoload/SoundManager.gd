extends Node

########################################
########## THE SOUND MANAGER ###########
########################################

@onready var soundScene = preload("res://sound/sound_effect.tscn")

var blockPlaceVol :float= 1.0
var blockMineVol :float = 1.2
var blockBreakVol :float = 1.4


func _process(delta):
	
	#blockPlaceVol = 0.8
	#blockMineVol  = 1.0
	#blockBreakVol = 1.2
	
	if GlobalRef.currentPlanet != null:
		var pos = GlobalRef.currentPlanet.posToTile(GlobalRef.player.position)
		if pos == null:
			return
		var depth = GlobalRef.currentPlanet.getSurfaceDistance(pos.x,pos.y)
		var wet = (depth - 20.5) / 100.0
		wet = clamp(wet,0.0,0.5)
		var effect = AudioServer.get_bus_effect(1,1) # gets reverb
		effect.wet = wet


func playSound(file:String,globalPos:Vector2,volumeLinear:float,pitchVariation:float=0.0,bus:String="SFX") -> void:
	var ins = soundScene.instantiate()
	ins.global_position = globalPos
	ins.stream = load("res://sound/" + file + ".ogg")
	ins.volume_db = linear_to_db(volumeLinear)
	ins.pitch_scale = randf_range( 1.0 - pitchVariation, 1.0 + pitchVariation )
	ins.bus = StringName(bus)
	add_child(ins)

func playSoundStream(stream:AudioStreamOggVorbis,globalPos:Vector2,volumeLinear:float,pitchVariation:float=0.0,bus:String="SFX") -> void:
	var ins = soundScene.instantiate()
	ins.global_position = globalPos
	ins.stream = stream
	ins.volume_db = linear_to_db(volumeLinear)
	ins.pitch_scale = randf_range( 1.0 - pitchVariation, 1.0 + pitchVariation )
	ins.bus = StringName(bus)
	add_child(ins)

func getMineSound(id:int=0) -> AudioStreamOggVorbis:
	
	var material = BlockData.getSoundMaterialID(id)
	
	match material:
		0: # stone
			return load("res://sound/mining/stoneMine.ogg")
		1: # dirt
			return load("res://sound/mining/dirtMine.ogg")
		2: # wood
			return load("res://sound/mining/woodMine.ogg")
		3: # sand / gravel
			return load("res://sound/mining/sandMine.ogg")
		5: # foliage
			return load("res://sound/mining/foliageMine.ogg")
		6: # glass
			return load("res://sound/mining/glassMine.ogg")
	return load("res://sound/mining/stoneMine.ogg")

func getBreakSound(id:int=0) -> AudioStreamOggVorbis:
	
	var material = BlockData.getSoundMaterialID(id)
	
	match material:
		0: # stone
			return load("res://sound/mining/stoneBreak.ogg")
		1: # dirt
			return load("res://sound/mining/dirtBreak.ogg")
		2: # wood
			return load("res://sound/mining/woodBreak.ogg")
		3: # sand / gravel
			return load("res://sound/mining/sandBreak.ogg")
		5: # foliage
			return load("res://sound/mining/foliageBreak.ogg")
		6: # glass
			return load("res://sound/mining/glassBreak"+ str((randi()%3)+1) +".ogg")
		
	return load("res://sound/mining/stoneBreak.ogg")
