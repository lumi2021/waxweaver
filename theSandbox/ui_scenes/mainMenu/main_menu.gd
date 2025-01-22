extends Node2D

var state :int=0 
# 0: main 
# 1: save files 
# 2: naming new save
# 3: are you sure?
# 4: options
# 5: web disclaimer
# 6: controls + tutorial
# 7: credits

@onready var selectedslot = $savefiles/ScrollContainer/VBoxContainer/saveslot

var waitUntilMusic :int= 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$mainButtons/versionLabel.text = "v0." + str( GlobalRef.version )
	SoundManager.deleteMusicNode()
	SoundManager.randomMusicTick = 170
	
	CreatureData.creatureAmount = 0 # ensures mob cap is reset if u leave game
	CreatureData.passiveAmount = 0
	
	if OS.has_feature("web"): # hide file directory buttons if on web
		$savefiles/openDirectory.hide()
		$savefiles/reloadSaves.hide()
		
		if !Saving.checkforgamesave(): # loads disclaimer if on web and there are no saves
			enterState(5)

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
		4:
			$mainButtons.hide()
			$optionsMenu.show()
		5:
			$mainButtons.hide()
			$disclaimer.show()
		6:
			$mainButtons.hide()
			$tutorial.show()
		7:
			$mainButtons.hide()
			$credits.show()
	
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
	$createNewWorld/Label.text = "generating... please be patient"
	await get_tree().create_timer(0.5).timeout
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


func _on_options_menu_menu_closed():
	enterState(0)


func _on_options_pressed():
	enterState(4)


func _on_okay_disclaimer_pressed():
	$disclaimer.hide()
	enterState(0)


func _on_gobacktutorial_pressed():
	$tutorial.hide()
	enterState(0)


func _on_tutorial_pressed():
	enterState(6)


func _on_text_edit_text_changed():
	
	$createNewWorld/TextEdit.text = $createNewWorld/TextEdit.text.replace("\n","")
	$createNewWorld/TextEdit.set_caret_column( $createNewWorld/TextEdit.text.length() )
	
	if $createNewWorld/TextEdit.text.length() > 20:
		$createNewWorld/TextEdit.text = $createNewWorld/TextEdit.text.left(20)
		$createNewWorld/TextEdit.set_caret_column(20)


func _on_credits_pressed():
	enterState(7)


func _on_gobackcredits_pressed():
	$credits.hide()
	enterState(0)
