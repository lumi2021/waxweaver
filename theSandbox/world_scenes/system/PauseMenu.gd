extends CanvasLayer

@onready var parent = get_parent()

func _process(delta):
	var secsSinceSave = int( Time.get_unix_time_from_system() ) - int(parent.lastSave)
	$lastsave.text = "last saved: " + str(secsSinceSave) + "s ago"
	$MouseIcon.position = get_viewport().get_mouse_position()


func _on_savegame_pressed():
	parent.saveGameToFile()
