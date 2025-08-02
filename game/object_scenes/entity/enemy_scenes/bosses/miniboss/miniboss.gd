extends Enemy

@onready var axis = $axis
@onready var bullet = preload("res://object_scenes/entity/enemy_scenes/bosses/miniboss/boss_projectile.tscn")
@onready var beamSprite = $Beam

var state :int = 0

var idleTicks :int = 0

var spawning :bool = false

var ticks :int= 0

var hasntBeamed :bool = true

func _process(delta):
	axis.rotation = lerp_angle(axis.rotation,getWorldRot(self),0.2)
	ticks += 1
	
	if ticks % 10 == 0:
		$axis/Robe.frame = ($axis/Robe.frame + 1) % 3
	$axis/OrbItem.position.x = sin(ticks * 0.05)
	$axis/OrbItem.position.y = sin(ticks * 0.1)
	
	$axis/OrbItem.scale = lerp($axis/OrbItem.scale,Vector2(1,1),0.1  )
	$axis/OrbItem.modulate = lerp($axis/OrbItem.modulate,Color.WHITE,0.1  )
	
	setLight(1.0)
	
	match state:
		0:
			idle(delta)
		1:
			bullets()
	
	if GlobalRef.player.dead:
		state = 5
		await get_tree().create_timer(2.0).timeout
		
		SoundManager.playSound("items/teleport",global_position,0.6,0.04)
		
		queue_free()
		
		

func idle(delta):
	idleTicks += 1
	if idleTicks > 140:
		idleTicks = 0
		teleportrandom()
		state = 1
		if healthComp.getHealthPercent() < 0.1:
			spawnBullets(16)
			return
		if healthComp.getHealthPercent() < 0.25:
			spawnBullets(12)
			return
		if healthComp.getHealthPercent() < 0.5:
			spawnBullets(10)
			return
		if healthComp.getHealthPercent() < 0.75:
			spawnBullets(8)
			return
		spawnBullets(6)
		
func bullets():
	if !spawning:
		state = 0

func spawnBullets(amount:int):
	spawning = true
	await get_tree().create_timer(0.8).timeout
	for i in range(amount):
		
		var ins = bullet.instantiate()
		ins.position = position
		var dir :Vector2= Vector2(0,48).rotated( randf_range(0.0,2.0*PI) )
		ins.velocity = dir * 2.5
		ins.penis = false
		ins.planet = planet
		get_parent().add_child(ins)
		bump()
		SoundManager.playSound("enemy/boss/final/projectile",ins.global_position,0.5, 0.1 )
		await get_tree().create_timer(0.8).timeout
	spawning = false

func teleportrandom():
	for i in range(25):
		var range = (randi() % 96) + 64
		var dir :Vector2 = Vector2(0,range).rotated(randf_range(0.0,PI*2.0))
		
		var pos = planet.posToTile( planet.to_local(GlobalRef.player.global_position + dir) )
		if pos == null:
			continue
		if planet.DATAC.getTileData(int(pos.x),int(pos.y)) > 1:
			continue
		
		global_position = GlobalRef.player.global_position + dir
		$axis/teleport.emitting = true
		SoundManager.playSound("items/teleport",global_position,0.6,0.04)
		if getDirectionTowardsPlayer() != 1:
			$axis/Robe.flip_h = true
		else:
			$axis/Robe.flip_h = false
		hasntBeamed = true
		return


		
func bump():
	$axis/OrbItem.scale = Vector2(2.0,2.0)
	$axis/OrbItem.modulate = Color(5.0,5.0,5.0,1.0)

func beam():
	setLight(2.0)
	GlobalRef.playerHC.inflictStatus("confused",4.0)
	SoundManager.playSound("enemy/confuseRay",global_position,1.2,0.05)
	beamSprite.scale = Vector2.ZERO
	beamSprite.modulate.a = 1.0
	var tween :Tween= get_tree().create_tween()
	tween.tween_property(beamSprite,"scale",Vector2(1.0,1.0),0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)
	tween.tween_property(beamSprite,"modulate:a",0.0,0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)
	tween.set_parallel(true)


func _on_health_component_smacked():
	var dis = GlobalRef.player.global_position.distance_to(global_position)
	if idleTicks > 1 and dis < 32 and hasntBeamed:
		beam()
		hasntBeamed = false


func _on_health_component_died():
	AchievementData.unlockMedal("defeatminiboss")
