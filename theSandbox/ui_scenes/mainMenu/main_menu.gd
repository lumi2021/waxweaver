extends Node2D

var state :int=0 
# 0: main 
#1: save files 
#2: naming new save
# 3: are you sure?

@onready var selectedslot = $savefiles/ScrollContainer/VBoxContainer/saveslot

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$mainButtons/versionLabel.text = "v0." + str( GlobalRef.version )

func _process(delta):
	$bg/backgroundLayer.scroll(Vector2(0.1,0))
	$MouseIcon.position = get_local_mouse_position()

func enterState(newstate):
	match newstate:
		1:
			$savefiles.show()
			$mainButtons.hide()
			$createNewWorld.hide()
			$areyousure.hide()
		0:
			if state == 1:
				$savefiles.hide()
			$mainButtons.show()
		2:
			$createNewWorld.show()
			$savefiles.hide()
		3:
			$areyousure.show()
			$savefiles.hide()
	
	$bg/AnimatedSprite2D.visible = newstate == 0
	$bg/AnimatedSprite2D2.visible = newstate == 0

	state = newstate

func _on_quit_pressed():
	if !OS.has_feature("web"):
		get_tree().quit()


func _on_play_pressed():
	enterState(1)


func _on_back_save_pressed():
	enterState(0)

func createNewSave(slot):
	selectedslot = slot
	enterState(2)

func _on_confirm_pressed():
	Saving.worldName = $createNewWorld/TextEdit.text
	selectedslot.createNewWorld()


func _on_cancel_pressed():
	enterState(1)

func areyousuredelete(slot):
	selectedslot = slot
	enterState(3)


func _on_yes_pressed():
	enterState(1)
	selectedslot.deleteSave()
