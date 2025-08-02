extends itemHeldClass

var time :float= 0.0

func onEquip():
	visible = true
	$origin/spr/emmisive.texture = itemData.emissiveTex

func onFirstUse():
	pass

func onUsing(delta):
	time += delta
	
	$origin.position = Vector2(3,-1)
	sprite.rotation_degrees = -30
	
	if time > itemData.delay:
		time = 0.0
		var cost :int= itemData.manaCost
		if Stats.specialProperties.has("mana25"):
			cost = int(itemData.manaCost * 0.75)
		if PlayerData.useMana(cost):
			summonObject()
		else:
			SoundManager.playSound("items/staffOutofMana",global_position,1.0)
	
func onNotUsing(delta):
	time += delta
	
	$origin.position = Vector2.ZERO
	sprite.rotation_degrees = -45

func summonObject():
	
	if itemData.summoningObject == null:
		return
	
	var ins = itemData.summoningObject.instantiate()
	ins.planet = getWorld().get_parent()
	ins.global_position = global_position
	
	if itemData.ejectPower != 0:
		var dir = getDirectionTowardsMouse()
		ins.velocity = itemData.ejectPower * dir
	
	getWorld().add_child(ins)
	ins.global_position = global_position + Vector2(0,-8).rotated(GlobalRef.camera.rotation)
	SoundManager.playSound("items/staffUse",global_position,1.0,0.1)
