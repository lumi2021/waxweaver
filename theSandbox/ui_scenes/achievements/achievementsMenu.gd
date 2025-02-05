extends Node2D

@onready var medalBoxScene = preload("res://ui_scenes/achievements/medal_box.tscn")

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
