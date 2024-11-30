extends Node2D
class_name itemHeldClass

var itemID :int= 0
var handColor :Color=Color.WHITE

@export var sprite :Sprite2D = null
@export var handSprite :Sprite2D = null

var itemData = null
var currentlyUsing
var clickUsage :bool = false

var usedUp = false
var isVisible = false
var override = false # if true, instead of player hand using visibily it will use the variable

func _ready():
	itemData = ItemData.getItem(itemID)
	if sprite != null:
		sprite.texture = itemData.texture
	if handSprite != null:
		handSprite.modulate = handColor
	clickUsage = itemData.clickToUse
	
	onEquip()

# copy deez
func onEquip():
	pass

func onFirstUse():
	pass

func onUsing(delta):
	pass

func onNotUsing(delta):
	pass

func _process(delta):
	invUpdate()
	if GlobalRef.player.dead:
		queue_free()

func invUpdate():
	usedUp = PlayerData.getSelectedItemID() != itemID

func getWorld():
	return GlobalRef.player.get_parent()

func getLocalMouse():
	var m = get_local_mouse_position()
	m.x *= get_parent().get_parent().scale.x
	return m

func getDirectionTowardsMouse():
	return getLocalMouse().normalized().rotated(GlobalRef.camera.rotation)
