extends TextureProgressBar

@onready var label = $Label

var wasActive = false

func _ready():
	set_process(false)


func _process(delta):
	if is_instance_valid(CreatureData.boss):
		
		value = CreatureData.boss.healthComp.health
		label.text = str(value) + " / " + str(max_value)
		wasActive = true
	else:
		SoundManager.stopBossMusic()
		hide()
		set_process(false)

func textSet(h:int,m:int):
	label.text = str(h) + " / " + str(m)
