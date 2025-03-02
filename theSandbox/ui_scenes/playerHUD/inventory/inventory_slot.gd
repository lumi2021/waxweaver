extends Node2D

@export var slotToDisplay := 0
@export var showOutline := true

@export var isHoldSlot := false

@export var customToolTip :String = ""

var parent = null

@export var selectedColor :Color = Color.WHITE
@export var notSelectedColor :Color = Color.WHITE

func _ready():
	PlayerData.updateInventory.connect(updateDisplay)
	$Slot.visible = showOutline
	updateDisplay()
	updateSelected()
	
	if isHoldSlot:
		$button.queue_free()
		$itemTexture.material = null
	
	if customToolTip != "":
		$button.tooltip_text = customToolTip

func updateSelected():
	if slotToDisplay == PlayerData.selectedSlot:
		$Slot.modulate = selectedColor
		$Label.label_settings.outline_color = selectedColor
	else:
		$Slot.modulate = notSelectedColor
		$Label.label_settings.outline_color = notSelectedColor
	
func updateDisplay():
	
	if PlayerData.inventory.size() <= slotToDisplay:
		return
	
	var slotInfo = PlayerData.inventory[slotToDisplay]
	
	if slotInfo[0] == -1:
		$itemTexture.texture = null
		$Label.visible = false
		return
	
	var itemData = ItemData.data[slotInfo[0]]
	var count = slotInfo[1]
	
	
	$itemTexture.texture = itemData.texture
	$Label.text = str(count)
	
	$Label.visible = itemData.maxStackSize != 1
	

func _on_color_rect_gui_input(event):
	if parent == null:
		return
	if event is InputEventMouseButton:
		if event["pressed"]:
			if event["button_index"] == 1:
				parent.clickedSlot(slotToDisplay)
				
				if slotToDisplay < 10 and !parent.invOpen:
					if PlayerData.inventory[49][0] != -1:
						# is holding item
						if PlayerData.inventory[slotToDisplay][0] == -1:
							PlayerData.inventory[slotToDisplay] = PlayerData.inventory[49]
							PlayerData.inventory[49] = [-1,-1]
							PlayerData.emit_signal("updateInventory")
						
					parent.selectSlot(slotToDisplay)
				
			if event["button_index"] == 2:
				if slotToDisplay < 40 or slotToDisplay > 52: # used to disable right click on armor slots
					parent.splitSlot(slotToDisplay)


func _on_button_mouse_entered():
	var s = PlayerData.inventory[slotToDisplay]
	var n = ItemData.getItemName(s[0])
	GlobalRef.hotbar.displayItemName(n,ItemData.getItem( PlayerData.inventory[slotToDisplay][0]))


func _on_button_mouse_exited():
	GlobalRef.hotbar.displayItemName("",null)
