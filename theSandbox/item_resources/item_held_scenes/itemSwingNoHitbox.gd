extends itemHeldClass

@onready var rotOrigin = $holder

var rotSpeed = 10.0

var swingOut = false

func onEquip():
	visible = false
	sprite.texture = itemData.texture

func onFirstUse():
	if swingOut:
		return
	rotOrigin.rotation_degrees = -60.0
	visible = true
	swingOut = true

func onUsing(delta):
	
	rotOrigin.rotation_degrees += rotSpeed * delta * 60.0
	if rotOrigin.rotation_degrees > 50:
		if !clickUsage:
			rotOrigin.rotation_degrees = -60.0
		else:
			swingOut = false
			turnOff()

func onNotUsing(delta):
	if swingOut:
		rotOrigin.rotation_degrees += rotSpeed * delta * 60.0
		if rotOrigin.rotation_degrees > 50:
			swingOut = false
			turnOff()
	else:
		turnOff()

func turnOff():
	visible = false
