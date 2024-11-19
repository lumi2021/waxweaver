extends itemHeldClass

@onready var origin = $origin

@onready var bulletScene = preload("res://items/weapons/bullets/bullet_entity.tscn")

var tick :float= -1.0

func onEquip():
	pass

func onFirstUse():
	pass

func onUsing(delta):
	visible = true
	scale.x = get_parent().get_parent().scale.x
	
	var dir = global_position.direction_to(get_global_mouse_position())
	origin.rotation = dir.angle() - get_parent().get_parent().rotation
	
	if abs(dir.rotated( GlobalRef.player.rotated * -(PI/2) ).angle()) > PI/2:
		sprite.flip_v = true
		sprite.rotation_degrees = -45
	else:
		sprite.flip_v = false
		sprite.rotation_degrees = 45
		
	
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
	
	
	var i = PlayerData.scanForBullet()
	if i == null:
		return
	
	PlayerData.consumeFromSlots([i[1]],1)
	PlayerData.emit_signal("updateInventory")
	
	var ins = bulletScene.instantiate()
	ins.damage = Stats.getRangedDamage(itemData.damage + i[0].damage)
	ins.statusInflictors = itemData.statusInflictors + i[0].statusInflictors
	#ins.planet = GlobalRef.currentPlanet
	ins.dir = Vector2(1,0).rotated(origin.global_rotation - get_parent().get_parent().rotation)
	ins.position = GlobalRef.player.position
	GlobalRef.player.get_parent().add_child(ins)

