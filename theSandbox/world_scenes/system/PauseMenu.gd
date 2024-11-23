extends CanvasLayer

@onready var parent = get_parent()

func _process(delta):
	var secsSinceSave = int( Time.get_unix_time_from_system() ) - int(parent.lastSave)
	$lastsave.text = "last saved: " + str(secsSinceSave) + "s ago"
	$MouseIcon.position = get_viewport().get_mouse_position()


func _on_savegame_pressed():
	parent.saveGameToFile()


func _on_unpause_pressed():
	get_tree().paused = false
	hide()


func _on_saveandquit_pressed():
	parent.saveGameToFile()
	get_tree().paused = false
	SoundManager.deleteAllSounds()
	get_tree().change_scene_to_file("res://ui_scenes/mainMenu/main_menu.tscn")

