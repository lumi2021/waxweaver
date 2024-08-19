extends itemHeldClass

@onready var origin = $origin

@onready var arrowScene = preload("res://object_scenes/entity/enemy_scenes/playerArrow/player_arrow.tscn")

var tick :float= -1.0

func onEquip():
	pass

func onFirstUse():
	pass

func onUsing(delta):
	visible = true
	scale.x = get_parent().get_parent().scale.x
	
	origin.rotation = global_position.direction_to(get_global_mouse_position()).angle() - get_parent().get_parent().rotation
	
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
	
	
	var i = PlayerData.scanForArrow()
	if i == null:
		return
	
	PlayerData.consumeFromSlots([i[1]],1)
	PlayerData.emit_signal("updateInventory")
	
	var ins = arrowScene.instantiate()
	ins.damage = Stats.getRangedDamage(itemData.damage + i[0].damage)
	ins.speed = itemData.velocity * i[0].velocityMultiplier
	ins.statusInflictors = itemData.statusInflictors + i[0].statusInflictors
	ins.tex = i[0].texture
	ins.dir = Vector2(1,0).rotated(origin.global_rotation - get_parent().get_parent().rotation)
	#print(Vector2(1,0).rotated(origin.global_rotation))
	ins.position = GlobalRef.player.position
	GlobalRef.player.get_parent().add_child(ins)

