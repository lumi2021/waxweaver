extends itemHeldClass

@onready var spear = $origin/sprite
@onready var origin = $origin
var extending :bool = false

var used :bool = false


func onEquip():
	hide()
	$origin/sprite/Hurtbox.damage = itemData.damage

func onFirstUse():
	show()

func onUsing(delta):
	if extending:
		return
	show()
	spear.position = Vector2.ZERO
	scale.x = get_parent().get_parent().scale.x
	
	origin.rotation = global_position.direction_to(get_global_mouse_position()).angle() - get_parent().get_parent().rotation
	used = true

func onNotUsing(delta):
	scale.x = get_parent().get_parent().scale.x
	if !used:
		return
	if extending:
		return
	
	$origin/sprite/Hurtbox.shuffleId()
	
	var speed = itemData.speedMult* (2.0 - Stats.getAttackSpeedMult())
	
	extending = true
	$origin/sprite/Hurtbox/CollisionShape2D.call_deferred("set_disabled",false)
	var tweenOut = get_tree().create_tween()
	tweenOut.tween_property(spear,"position:x",15,0.2 * speed).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)
	
	await tweenOut.finished
	
	await get_tree().create_timer(0.2 * itemData.speedMult).timeout
	
	var tweenIn = get_tree().create_tween()
	tweenIn.tween_property(spear,"position:x",0,0.4 * speed)
	
	await tweenIn.finished
	hide()
	$origin/sprite/Hurtbox/CollisionShape2D.call_deferred("set_disabled",true)
	extending = false
	used = false
