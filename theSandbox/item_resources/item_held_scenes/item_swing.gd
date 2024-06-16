extends itemHeldClass

@onready var rotOrigin = $holder

var rotSpeed = 1.0

var swingOut = false

func onEquip():
	$holder/Hurtbox.damage =  itemData.damage
	rotSpeed = itemData.animSpeed
	visible = false

func onFirstUse():
	if swingOut:
		return
	rotOrigin.rotation_degrees = -60.0
	visible = true
	swingOut = true
	mm()
	$holder/Hurtbox/CollisionShape2D.disabled = false

func onUsing():
	rotOrigin.rotation_degrees += rotSpeed
	if rotOrigin.rotation_degrees > 50:
		if !clickUsage:
			rotOrigin.rotation_degrees = -60.0
			mm()
		else:
			swingOut = false
			turnOff()

func onNotUsing():
	if swingOut:
		rotOrigin.rotation_degrees += rotSpeed
		if rotOrigin.rotation_degrees > 50:
			swingOut = false
			turnOff()
	else:
		turnOff()

func turnOff():
	visible = false
	$holder/Hurtbox/CollisionShape2D.disabled = true

func mm():
	$holder/Hurtbox.shuffleId()
