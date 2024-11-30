extends Node2D

var state :int=0 
# 0: main 
#1: save files 
#2: naming new save
# 3: are you sure?

@onready var selectedslot = $savefiles/ScrollContainer/VBoxContainer/saveslot

var waitUntilMusic :int= 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$mainButtons/versionLabel.text = "v0." + str( GlobalRef.version )
	SoundManager.deleteMusicNode()
	
	if OS.has_feature("web"): # hide file directory buttons if on web
		$savefiles/openDirectory.hide()
		$savefiles/reloadSaves.hide()

func _process(delta):
	$bg/backgroundLayer.scroll(Vector2(0.1,0))
	$MouseIcon.position = get_local_mouse_position()
	if waitUntilMusic == 1200:
		$Music.play()
	waitUntilMusic += 1
	
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


func _on_discord_pressed():
	Saving.open_site("https://discord.com/invite/d6N8tbgW98")


func _on_open_directory_pressed():
	Saving.open_site(ProjectSettings.globalize_path("user://"))


func _on_reload_saves_pressed():
	for child in $savefiles/ScrollContainer/VBoxContainer.get_children():
		child.setData()
