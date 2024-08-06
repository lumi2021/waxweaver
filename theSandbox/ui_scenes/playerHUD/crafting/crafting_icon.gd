extends CenterContainer

@onready var sprite = $TextureRect
@onready var label = $txt/txt

@onready var craftMain = get_parent().get_parent().get_parent()

var craftID = 0
var data
var canCraft = true
var inv = [[],[]]

var parent = null

var stationCheck = 0
var stationOffset = 0

var hasStation = false
var shouldShowUncraftable = true

func _ready():
	data = CraftData.getCraft(craftID)
	
	sprite.texture = ItemData.getItem(data["crafts"]).texture
	label.text = str(data["amount"])
	
	for i in range(data["ingredients"].size()):
		if !inv[0].has(data["ingredients"][i]):
			canCraft = false
			break
		else:
			var arraypos = inv[0].find(data["ingredients"][i])
			if inv[1][arraypos] < data["ingAmounts"][i]:
				canCraft = false
				break
	vis()
	
	if data.has("station"):
		stationOffset = randi() % 30
		determineStation()
	updateIfUncraftable()
	
func vis():
	$CraftingIcon.visible = canCraft
	$CantCraft.visible = !canCraft
	

func updateMe():
	for i in data["ingredients"].size():
		if PlayerData.checkForItemAmount(data["ingredients"][i]) < data["ingAmounts"][i]:
			canCraft = false
			vis()
			return # can not craft again
	canCraft = true # can craft again
	vis()


func _on_craft_button_mouse_entered():
	craftMain.displayCraftingInfo(craftID)


func _on_craft_button_mouse_exited():
	craftMain.displayCraftingInfo(null)


func _on_craft_button_pressed():
	if canCraft:
		var cra = PlayerData.craftItem(data)
		if cra != null:
			canCraft = cra
	vis()
	updateIfUncraftable()

func _process(delta):
	stationCheck += 1
	if stationCheck % 30 == stationOffset:
		determineStation()
		updateIfUncraftable()
	
	if hasStation and shouldShowUncraftable:
		visible = true
	else:
		visible = false

func determineStation():
	if data.has("station"):
		var id = data["station"]
		hasStation = craftMain.stationScan.has(id)
		return
	hasStation = true

func updateIfUncraftable():
	if !canCraft:
		shouldShowUncraftable = craftMain.showUncraftables
	else:
		shouldShowUncraftable = true
