extends Enemy

## STATES ##
# PHASE 1
# 0 = intro
# 1 = idle bob
# 2 = beam
# 3 = status effect
# 4 = imitation
# 5 = teleporting
# 6 = transforming into phase 2

# PHASE 2
# 7 = idle, follow player, bob randomly
# 8 = double laser eyes
# 9 = cast random spell, chance of twisting gravity
# 10 = lightning cast
# 11 = spawn bullets
# 12 = spawn worms from eyes

@onready var axis = $axis

var focusedPosition :Vector2 = Vector2.ZERO

@onready var beam = preload("res://object_scenes/entity/enemy_scenes/bosses/finalBoss/boss_laser.tscn")
@onready var bullet = preload("res://object_scenes/entity/enemy_scenes/bosses/finalBoss/boss_projectile.tscn")
@onready var statusBullet = preload("res://object_scenes/entity/enemy_scenes/bosses/finalBoss/bossStatusProjectile.tscn")
@onready var lightning = preload("res://items/weapons/staffs/lightning/lightning.tscn")

@onready var pupilSprite = $axis/EyeWhites/Pupil
@onready var whitesSprite = $axis/EyeWhites

var tick:int=0

var eyeRotate :int= 1 

var split :int = 0

var haventSeenPlayerTicks :int = 0

var animTick :float = 0.0

func _process(delta):
	tick += 1
	animTick += delta
	seperate(split)
	
	$axis.rotation = getWorldRot(self)

func scanPlayer():
	$playerScan.target_position = to_local(GlobalRef.player.global_position)
	
	if $playerScan.is_colliding():
		haventSeenPlayerTicks += 1
	else:
		haventSeenPlayerTicks -= 1
		if haventSeenPlayerTicks < 0:
			haventSeenPlayerTicks = 0
	
	
func idlePhase1(delta):
	
	
	focusedPosition = GlobalRef.player.position + Vector2(0,-72).rotated(getWorldRot(self))
	velocity = lerp(velocity,position.direction_to( focusedPosition ) * 200.0,0.04)
	move_and_slide()
	
	
func slowToStop(delta):
	velocity = lerp(velocity,Vector2.ZERO,0.2)
	move_and_slide()

func focusOnPosition(delta):
	velocity = lerp(velocity,position.direction_to( focusedPosition ) * 200.0,0.04)
	move_and_slide()
	

func spawnBeam(dir:int,globalpos:Vector2):
	var ins = beam.instantiate()
	ins.dir = dir
	ins.global_position = globalpos
	ins.rotation = getExactDirToPlayer().angle() + ((PI/4.0) * -dir)
	get_parent().add_child(ins)
	ins.global_position = globalpos

func spawnBullets(amount:int):
	for i in range(amount):
		var ins = bullet.instantiate()
		var dir :Vector2= Vector2(0,48).rotated( randf_range(0.0,2.0*PI) )
		ins.position = position + dir
		ins.velocity = dir * 2.5
		get_parent().add_child(ins)
		await get_tree().create_timer(0.6).timeout

func spawnStatusBullets(amount:int,delay:float):
	for i in range(amount):
		var ins = statusBullet.instantiate()
		var dir :Vector2= Vector2(0,-32.0).rotated( randf_range((PI/4)*-1,PI/4) )
		ins.position = position + dir
		ins.velocity = dir * 4.0
		ins.planet = planet
		get_parent().add_child(ins)
		await get_tree().create_timer(delay).timeout

func seperate(amount:int):
	whitesSprite.position.x = amount
	$axis/dup.position.x = -amount
	
	if amount > 0:
		syncDuplicate()
		whitesSprite.modulate.a = lerp(whitesSprite.modulate.a,0.8,0.1)
		$axis/dup.modulate.a = lerp($axis/dup.modulate.a,0.8,0.1)
	else:
		whitesSprite.modulate.a = lerp(whitesSprite.modulate.a,1.0,0.2)
		$axis/dup.modulate.a = lerp($axis/dup.modulate.a,1.0,0.2)

func eyeLookAtPlayer():
	pupilSprite.position = lerp(pupilSprite.position,getExactDirToPlayer() * 6,0.08  )
	pupilSprite.rotation = 0.0
	pupilSprite.frame = 0
	pupilSprite.scale = Vector2(1.0,1.0)

func eyeLaser(delta):
	pupilSprite.position = lerp(pupilSprite.position,Vector2.ZERO,0.05  )
	pupilSprite.rotate(64.0*delta*eyeRotate)
	var r = randf_range(0.8,1.2)
	pupilSprite.scale = Vector2(r,r)
	if tick % 3 == 0:
		if pupilSprite.frame <= 1:
			pupilSprite.frame = 2
		else:
			pupilSprite.frame = 1
	

func eyeSpastic(frame:int):
	pupilSprite.position = lerp(pupilSprite.position,Vector2.ZERO,0.05  )
	pupilSprite.rotation = 0.0
	var r = randf_range(0.8,1.2)
	pupilSprite.scale = Vector2(r,r)
	pupilSprite.frame = frame

func eyeLookAtPlayerPhase2(delta):
	pupilSprite.position = lerp(pupilSprite.position,getExactDirToPlayer() * 6,0.08  )
	pupilSprite.rotate(64.0*delta*eyeRotate)
	pupilSprite.frame = 5
	var r = randf_range(0.8,1.2)
	pupilSprite.scale = Vector2(r,r)

func syncDuplicate():
	$axis/dup/dupp.position = pupilSprite.position
	$axis/dup/dupp.frame = pupilSprite.frame
	$axis/dup/dupp.scale = pupilSprite.scale
	$axis/dup/dupp.rotation = pupilSprite.rotation

func overrideGravity(override:int,length:float):
	if GlobalRef.playerGravityOverride != -1:
		#GlobalRef.playerGravityOverride = -1
		return
	
	GlobalRef.playerGravityOverride = override
	await get_tree().create_timer(length).timeout
	
	GlobalRef.playerGravityOverride = -1
	

func summonLightning():
	var offset :float= 200.0
	for l in range(6):
		var ins = lightning.instantiate()
		ins.global_position = global_position + Vector2(offset,0).rotated(getWorldRot(self))
		ins.velocity = Vector2(0,300).rotated(getWorldRot(self))
		ins.planet = planet
		ins.shotByPlayer = false
		get_parent().add_child(ins)
		ins.global_position = global_position + Vector2(offset,0).rotated(getWorldRot(self))
		
		offset -= 66.66
		await get_tree().create_timer(0.2).timeout

func moveBody(oldPos:Vector2,newPos:Vector2):
	var change :Vector2 = newPos - oldPos
	var previousSegment = self
	
	var i :int = 0
	for segment in $axis/fuck.get_children():
		
		segment.position -= change
		
		var segmentSpace :Vector2= segment.global_position - previousSegment.global_position
		var targetPosition = previousSegment.global_position + (segmentSpace.normalized() * 24)
		
		var angle = rad_to_deg(segmentSpace.angle())
		var min = -158
		var max = -112
		match i:
			1:
				min = -68
				max = -22
			2:
				min = 50
				max = 80
			3:
				min = 100
				max = 130
		if angle != clamp(angle,min,max):
			segment.position += change
			i += 1
			continue
		
		if segmentSpace.length() > 24:
			segment.global_position = targetPosition
		
		i += 1
	
	animateWings()

func animateWings():
	var s = sin(animTick * 8) * 0.1 
	$axis/Wing.rotation = $axis/fuck/g.position.angle() + s + PI
	$axis/Wing2.rotation = $axis/fuck/g2.position.angle() + -s
	
	$axis/Wing3.rotation = $axis/fuck/g4.position.angle() + PI + (PI/2) + (-s*0.5)
	$axis/Wing4.rotation = $axis/fuck/g3.position.angle() - (PI/2) + (s*0.5)
