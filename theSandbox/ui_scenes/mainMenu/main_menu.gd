extends Node2D


func _on_button_pressed():
	Saving.loadedFile = "save1"
	get_tree().change_scene_to_file("res://world_scenes/system/system.tscn")


func _on_button_2_pressed():
	Saving.loadedFile = "save2"
	get_tree().change_scene_to_file("res://world_scenes/system/system.tscn")


func _on_button_3_pressed():
	Saving.loadedFile = "save3"
	get_tree().change_scene_to_file("res://world_scenes/system/system.tscn")
