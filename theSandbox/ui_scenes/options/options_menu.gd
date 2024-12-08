extends Node2D

@onready var sfxSlider = $ScrollContainer/g/buttons/sfxslider/sfxslide
@onready var musicSlider = $ScrollContainer/g/buttons/musicslider/musslide
@onready var ambientSlider = $ScrollContainer/g/buttons/ambientslider/ambslide

signal menuClosed

func _ready():
	loadOptions()

func loadOptions():
	sfxSlider.value = Options.options["sfxVolume"]
	musicSlider.value = Options.options["musicVolume"]
	ambientSlider.value = Options.options["ambientVolume"]
	setShadowText()

func _on_dropshadow_pressed():
	Options.options["showShadow"] = !Options.options["showShadow"]
	Options.applyOptions()
	setShadowText()

func setShadowText():
	if Options.options["showShadow"]:
		$ScrollContainer/g/buttons/dropshadow.buttonText = "show drop shadow: true"
	else:
		$ScrollContainer/g/buttons/dropshadow.buttonText = "show drop shadow: false"

func _on_done_pressed():
	closeMenu()

func closeMenu():
	hide()
	emit_signal("menuClosed")




func _on_sfxslide_value_changed(value):
	Options.options["sfxVolume"] = value
	Options.applyOptions()
	$ScrollContainer/g/buttons/sfxslider/Label.text = str(value*100)


func _on_musslide_value_changed(value):
	Options.options["musicVolume"] = value
	Options.applyOptions()
	$ScrollContainer/g/buttons/musicslider/Label.text = str(value*100)


func _on_ambslide_value_changed(value):
	Options.options["ambientVolume"] = value
	Options.applyOptions()
	$ScrollContainer/g/buttons/ambientslider/Label.text = str(value*100)


func _on_sfx_pressed():
	sfxSlider.value = 1.0
func _on_music_pressed():
	musicSlider.value = 1.0
func _on_ambient_pressed():
	ambientSlider.value = 1.0


func _on_fullscreen_pressed():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		
	elif DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

	elif DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_MAXIMIZED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	
