extends Node2D

@onready var medalBoxScene = preload("res://ui_scenes/achievements/medal_box.tscn")

signal menuClosed

func _ready():
	initializeAchievements()

func initializeAchievements():
	for medal in AchievementData.medalDictionary:
		var ins = medalBoxScene.instantiate()
		var dic = AchievementData.medalDictionary[medal]
		if AchievementData.isMedalUnlocked(medal):
			ins.setData(load(dic["icon"]),dic["name"],dic["desc"])
		else:
			ins.setData(null,dic["name"],dic["desc"])
		$ScrollContainer/VBoxContainer.add_child(ins)

func clear():
	for c in $ScrollContainer/VBoxContainer.get_children():
		c.queue_free()

func _on_text_button_pressed():
	hide()
	emit_signal("menuClosed")
