extends Enemy

var damage :int= 3
var speed :float= 10.0

var dir :Vector2= Vector2.ZERO

var deletable = true
var ticksTilDelete := 0.0

var tex :Texture2D

var statusInflictors :Array[StatusInflictor] = []

var state :int = 0 # 0 is flying, 1 is stuck

var itemID :int= 3004

func _ready():
	SoundManager.playSound("items/bowFire",global_position,5.0,0.1)
	#setVelocity(dir.normalized() * speed)
	velocity = to_local(get_global_mouse_position()).normalized() * speed
	$axis/Hurtbox.damage = damage
	$axis/Hurtbox.statusInflictors = statusInflictors
	$axis.rotation = velocity.angle()
	
	$axis/Arrow.texture = tex
	
	#await get_tree().create_timer(0.1).timeout
	#$CollisionShape2D.disabled = false
	#$axis/Arrow.visible = true
	#deletable = true

func _process(delta):
	if state == 0:
		fly(delta)
	else:
		stuck(delta)

func fly(delta):
	var vel = getVelocity()
	
	vel.y += 400 * delta
	
	setVelocity(vel)
	move_and_slide()
	
	#$axis.rotation = velocity.angle()
	
	if $axis/RayCast2D.is_colliding():
		setVelocity(Vector2.ZERO)
		SoundManager.playSound("items/arrowLand",global_position,1.0,0.1)
		state = 1
		$axis/Hurtbox/CollisionShape2D.call_deferred("set_disabled",true)
	else:
		$axis.rotation = velocity.angle()
	
func stuck(delta):
	
	if !$axis/RayCast2D.is_colliding():
		state = 0
		$axis/Hurtbox/CollisionShape2D.call_deferred("set_disabled",false)
		return
	
	if deletable:
		ticksTilDelete += delta
		if ticksTilDelete > 30.0:
			queue_free()
	
	
	
func _on_hurtbox_hitsomething():
	SoundManager.playSound("items/arrowLand",global_position,1.0,0.1)
	queue_free()



func _on_area_2d_body_entered(body):
	# player entered
	if state == 1:
		PlayerData.addItem(itemID,1)
		var itemData = ItemData.getItem(itemID)
		Indicators.itemPopup(itemData.itemName,1,global_position)
		SoundManager.playSound("inventory/pickupItem",global_position,1.0,0.12,"INVENTORY")
		queue_free()
