extends Node

########################################
########## THE SOUND MANAGER ###########
########################################

@onready var soundScene = preload("res://sound/sound_effect.tscn")

var blockPlaceVol :float= 1.0
var blockMineVol :float = 1.2
var blockBreakVol :float = 1.4

var randomMusicTick :float = 0
var randomAmbientTick :float = 0

var musicNode = null
var ambientNode = null

var lastplayedmusic :int = -1

func _process(delta):
	
	#blockPlaceVol = 0.8
	#blockMineVol  = 1.0
	#blockBreakVol = 1.2
	
	if is_instance_valid(GlobalRef.currentPlanet) and is_instance_valid(GlobalRef.player):
		var pos = GlobalRef.currentPlanet.posToTile(GlobalRef.player.position)
		if pos == null:
			return
		var depth = GlobalRef.currentPlanet.getSurfaceDistance(pos.x,pos.y)
		var wet = (depth - 20.5) / 100.0
		wet = clamp(wet,0.0,0.5)
		var effect = AudioServer.get_bus_effect(1,1) # gets reverb
		effect.wet = wet
		
		if musicNode == null:
			randomMusicTick += delta
			if randomMusicTick >= 180:
				var penis = randi() % 7
				if lastplayedmusic == penis:
					penis += 1
					penis = penis % 7
				
				if GlobalRef.globalTick < 900:
					penis = 3
				
				
				match penis:
					0:
						playMusic("music/planet ambience",1.0)
					1:
						playMusic("music/harnessforplanet",0.4)
					2:
						playMusic("music/baron",0.12) # https://www.newgrounds.com/audio/listen/1381586
					3:
						playMusic("music/air",0.2) # https://www.newgrounds.com/audio/listen/1380380
					4:
						playMusic("music/pan",0.2) # https://www.newgrounds.com/audio/listen/1382109
					5:
						playMusic("music/eyes",0.2) # https://www.newgrounds.com/audio/listen/1381914
					6:
						playMusic("music/ticks",0.1) # https://www.newgrounds.com/audio/listen/1382542
				
				lastplayedmusic = penis
		
		if ambientNode == null:
			randomAmbientTick += delta
			if randomAmbientTick >= 2:
				if randi() % 2 == 0:
					playAmbient("ambient/softwindnoloop",0.1)
				else:
					playAmbient("ambient/spookywind",0.1)


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
			return load("res://sound/mining/glassBreak1.ogg")
		
	return load("res://sound/mining/stoneBreak.ogg")

func deleteAllSounds():
	for child in get_children():
		child.queue_free()

func playMusic(file:String,volumeLinear:float,bus:String="MUSIC") -> void:
	
	var ins = AudioStreamPlayer.new()
	ins.stream = load("res://sound/" + file + ".ogg")
	ins.autoplay = true
	ins.volume_db = linear_to_db(volumeLinear)
	ins.bus = StringName(bus)
	musicNode = ins
	ins.connect("finished",deleteMusicNode)
	add_child(ins)

func deleteMusicNode():
	if !is_instance_valid(musicNode):
		musicNode = null
		randomMusicTick = -10.0
		return
	musicNode.queue_free()
	musicNode = null
	
	randomMusicTick = -10.0

func playAmbient(file:String,volumeLinear:float,bus:String="AMBIENT") -> void:
	
	var ins = AudioStreamPlayer.new()
	ins.stream = load("res://sound/" + file + ".ogg")
	ins.autoplay = true
	ins.volume_db = linear_to_db(volumeLinear)
	ins.bus = StringName(bus)
	ambientNode = ins
	ins.connect("finished",deleteAmbientNode)
	add_child(ins)

func deleteAmbientNode():
	if !is_instance_valid(ambientNode):
		ambientNode = null
		randomAmbientTick = -10.0
		return
	ambientNode.queue_free()
	ambientNode = null
	
	randomAmbientTick = -10.0
