extends itemHeldClass

@onready var rotOrigin = $holder

var rotSpeed = 1.0

var swingOut = false

func onEquip():
	
	Stats.updatedStats.connect( getData )
	getData()
	visible = false

func onFirstUse():
	if swingOut:
		return
	rotOrigin.rotation_degrees = -60.0
	visible = true
	swingOut = true
	mm()
	$holder/Hurtbox/CollisionShape2D.disabled = false

func onUsing(delta):
	visible = true
	rotOrigin.rotation_degrees += rotSpeed * delta * 60.0
	if rotOrigin.rotation_degrees > 50:
		if !clickUsage:
			rotOrigin.rotation_degrees = -60.0
			mm()
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
	$holder/Hurtbox/CollisionShape2D.disabled = true

func mm():
	$holder/Hurtbox.shuffleId()

func getData():
	$holder/Hurtbox.damage =  Stats.getMeleeDamage(itemData.damage)
	$holder/Hurtbox.knockback = itemData.knockbackMult + Stats.getBonusKnockback()
	rotSpeed = itemData.animSpeed * Stats.getAttackSpeedMult()
	var empty :Array[StatusInflictor] = []
	$holder/Hurtbox.statusInflictors = empty
	$holder/Hurtbox.statusInflictors += itemData.statusInflictors
	
	if Stats.specialProperties.has("firecharm"):
		var status = StatusInflictor.new()
		status.effectName = "burning"
		status.seconds = 5
		status.chance = 25
		$holder/Hurtbox.statusInflictors.append(status)
	if Stats.specialProperties.has("poisoncharm"):
		var status = StatusInflictor.new()
		status.effectName = "poison"
		status.seconds = 5
		status.chance = 25
		$holder/Hurtbox.statusInflictors.append(status)
