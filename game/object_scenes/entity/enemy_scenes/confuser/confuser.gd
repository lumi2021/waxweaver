extends Enemy

var state :int = 0 # 0 = wander, 1 = psychic attack 
@onready var axis = $axis
@onready var beamSprite = $Beam

var beaming :bool = false

func _physics_process(delta):
	match state:
		0:
			wander(delta)

func wander(delta):
	var vel = getVelocity()
	
	var targetX = getDirectionTowardsPlayer()
	var targetY = getVERTICALDirectionTowardsPlayer()
	
	var t = Vector2( targetX,targetY ).normalized() * 100.0
	
	var l = 1-pow(2, (-delta/1.0) )
	vel = lerp( vel, t, l )
	
	if $axis/wallCast.is_colliding():
		var target = vel.rotated( (PI/2) + randf_range(-1.0,1.0) )
		vel = target
		#vel = vel.normalized() * 100
	
	setVelocity(vel)
	move_and_slide() 
	
	if velocity.length() > 0.2:
		var prev = axis.rotation
		axis.rotation = velocity.angle() + (PI/2)
		$axis/Limb2.rotation = (axis.rotation - prev) * -10.0
		$axis/Limb2/Limb3.rotation = (axis.rotation - prev) * -10.0
	
	if getPlayerDistance() < 64:
		if randi() % 120 == 0:
			beam(delta)

func beam(delta):
	if beaming:
		return
	beaming = true
	setLight(2.0)
	GlobalRef.playerHC.inflictStatus("confused",4.0)
	SoundManager.playSound("enemy/confuseRay",global_position,1.2,0.05)
	beamSprite.scale = Vector2.ZERO
	beamSprite.modulate.a = 1.0
	var tween :Tween= get_tree().create_tween()
	tween.tween_property(beamSprite,"scale",Vector2(1.0,1.0),0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)
	tween.tween_property(beamSprite,"modulate:a",0.0,0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)
	tween.set_parallel(true)
	await tween.finished
	beaming = false
