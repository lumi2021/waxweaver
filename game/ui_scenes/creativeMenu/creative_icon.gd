extends NinePatchRect

var id :int = 2
var itemData:Item

func _ready():
	itemData = ItemData.getItem(id)
	$sprite.texture = itemData.texture
	$shadow.texture = itemData.texture


func _on_get_item_pressed():
	var helditem = PlayerData.inventory[49][0]
	var heldamount = PlayerData.inventory[49][1]
	if helditem != id and helditem != -1:
		return # dont add if player already holding item
	
	if Input.is_action_pressed("shift"):
		PlayerData.inventory[49] = [id, itemData.maxStackSize]
	else:
		PlayerData.inventory[49] = [id, clamp(heldamount + 1,1,itemData.maxStackSize)]
	PlayerData.emit_signal("updateInventory")
	


func _on_get_item_mouse_entered():
	var n = ItemData.getItemName(id)
	GlobalRef.hotbar.displayItemName(n,ItemData.getItem(id))

func _on_get_item_mouse_exited():
	GlobalRef.hotbar.displayItemName("",null)
