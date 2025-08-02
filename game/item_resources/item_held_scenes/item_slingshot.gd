extends itemHeldClass

@onready var origin = $origin

@onready var slingScene = preload("res://object_scenes/entity/enemy_scenes/slingshotBullet/slingBullet.tscn")

var tick :float= -1.0

func onEquip():
	pass

func onFirstUse():
	pass

func onUsing(delta):
	visible = true
	scale.x = get_parent().get_parent().scale.x
	
	origin.rotation = global_position.direction_to(get_global_mouse_position()).angle() - get_parent().get_parent().rotation
	
	sprite.flip_v = abs(origin.rotation) > PI/2
	if sprite.flip_v:
		sprite.position.y = 2
	else:
		sprite.position.y = -2
	
	if tick <= 0.0:
		fire(delta)
		tick += itemData.fireRate * delta
	else:
		tick -= 60.0*delta * Stats.getAttackSpeedMult()

func onNotUsing(delta):
	visible = false
	if tick > 0.0:
		tick -= 60.0*delta

func fire(delta):
	
	
	var i = PlayerData.scanForBlock()
	if i == null:
		return
	var id = PlayerData.inventory[i[1]][0]
	PlayerData.consumeFromSlots([i[1]],1)
	PlayerData.emit_signal("updateInventory")
	
	var ins = slingScene.instantiate()
	ins.damage = Stats.getRangedDamage(itemData.damage)
	ins.speed = itemData.velocity #* i[0].velocityMultiplier
	ins.statusInflictors = itemData.statusInflictors# + i[0].statusInflictors
	ins.tex = i[0].texture
	ins.itemID = id
	ins.planet = GlobalRef.currentPlanet
	ins.dir = Vector2(1,0).rotated(origin.global_rotation - get_parent().get_parent().rotation)
	#print(Vector2(1,0).rotated(origin.global_rotation))
	ins.position = GlobalRef.player.position
	GlobalRef.player.get_parent().add_child(ins)

