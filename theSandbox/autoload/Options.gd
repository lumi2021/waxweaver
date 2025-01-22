extends Node

var defaultOptions :Dictionary= {
	"showShadow":true,
	"musicVolume":1.5,
	"sfxVolume":1.5,
	"ambientVolume":1.5,
	"autosaving":true,
}

var options :Dictionary = {}

signal updatedOptions

func _ready():
	options = defaultOptions.duplicate()
	var saved = Saving.read_save("options")
	if saved != null:
		for key in saved:
			options[key] = saved[key]
			# we do this iteration in case new options have appeared. 
			# this will make future default values not get overridden
	
	applyOptions()

func applyOptions():
	
	# sets audio bus volume
	var musicBus= AudioServer.get_bus_index("MUSIC")
	AudioServer.set_bus_volume_db(musicBus, linear_to_db(options["musicVolume"]) )
	var sfxBus= AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(sfxBus, linear_to_db(options["sfxVolume"]) )
	var ambientBus= AudioServer.get_bus_index("AMBIENT")
	AudioServer.set_bus_volume_db(ambientBus, linear_to_db(options["ambientVolume"]) )
	
	
	Saving.write_save("options",options)
	emit_signal("updatedOptions")
