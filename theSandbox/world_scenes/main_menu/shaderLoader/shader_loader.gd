extends Node2D

@onready var container = $container
@onready var label = $Label

signal clicked

var materialsToLoad = [
	"res://object_scenes/ground_item/groundItemOutlineShader.tres",
	"res://object_scenes/ground_item/tintItemShader.tres",
	"res://object_scenes/lightmapCover/lightmap.tres",
	"res://ui_scenes/playerHUD/inventory/slotMaterial.tres",
]
func _ready():
	
	RenderingServer.set_default_clear_color(Color.BLACK)
	
	var count = 0
	
	container.position.x = 216 - (16*materialsToLoad.size())
	
	label.text = "compiling shaders ( " + str(count+1) + " / " + str(materialsToLoad.size()) + " )"
	
	for i in materialsToLoad:
		
		var img = Sprite2D.new()
		img.texture = load("res://world_scenes/main_menu/shaderLoader/shaderPreview.png")
		img.position.x = count * 32
		img.material = load(i)
		container.add_child(img)
		
		label.text = "compiling shaders ( " + str(count+1) + " / " + str(materialsToLoad.size()) + " )"
		count += 1
		await get_tree().create_timer(0.15).timeout
	
	if OS.has_feature("web"):
		label.text = "click to focus window"
		await clicked
	
	get_tree().change_scene_to_file("res://ui_scenes/mainMenu/main_menu.tscn")


func _on_button_pressed():
	emit_signal("clicked")
