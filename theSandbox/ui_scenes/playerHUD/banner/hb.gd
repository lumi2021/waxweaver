extends TextureProgressBar

@onready var label = $Label

func _ready():
	set_process(false)


func _process(delta):
	if is_instance_valid(CreatureData.boss):
		
		value = CreatureData.boss.healthcomponent.health
		label.text = str(value) + " / " + str(max_value)
		
	else:
		
		hide()
		
		set_process(false)

func textSet(h:int,m:int):
	label.text = str(h) + " / " + str(m)
