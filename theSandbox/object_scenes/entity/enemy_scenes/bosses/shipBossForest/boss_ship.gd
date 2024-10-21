extends Enemy

@onready var healthcomponent = $HealthComponent
@onready var sprite = $axis/AnimatedSprite2D
@onready var groundRay = $axis/ground
@onready var axis = $axis

@onready var praffinScene = preload("res://object_scenes/entity/enemy_scenes/praffin/praffin.tscn")

var state :int= 0
## states:
# 0: position for swoop attack
# 1: swoop attack
# 2: chase

var swoopSide = 0
var swoopWait :int= -100

var swoopTimes :int= 0
var chaseTicks :int= 0

var settle := Vector2.ZERO
var spawningTicks = 39

var dashWhileChaseTicks = 0

func _ready():
	sprite.play("default")

func _physics_process(delta):
	match state:
		0:
			position4swoopAttack(delta)
		1:
			swoopAttack(delta)
		2:
			chase(delta)
		3:
			moveToSettle(delta)
		4:
			spawnPraffins(delta)
	
	# sprite rotation
	sprite.rotation = getVelocity().x * 0.001
	sprite.flip_h = getVelocity().x < 0.0
	axis.rotation = getWorldRot(self)

func position4swoopAttack(delta):
	if swoopSide == 0:
		swoopSide = ((randi() % 2) * 2) - 1 # gets either -1 or 1
	
	var targetPosition = GlobalRef.player.position + Vector2(128*swoopSide,-128).rotated(getWorldRot(self))
	velocity = lerp(velocity,position.direction_to( targetPosition ) * 200.0,0.04)
	move_and_slide()
	
	swoopWait += 1
	
	if swoopWait > 120:
		
		if swoopTimes >= 3:
			if healthcomponent.getHealthPercent() < 0.75: # switch to praffinspawning
				settle = determineSettlePosition()
				
				velocity += Vector2(0,20).rotated( getWorldRot(self) )
				
				state = 3
				healthcomponent.damageTypeImmunities = [1]
				
			else: # switch to chase
				state = 2
			swoopTimes = 0
			swoopWait = -40
			return
		
		state = 1
		swoopSide *= -1
		swoopTimes += 1
		var vel = Vector2(200*swoopSide,410)
		SoundManager.playSound("enemy/boss/bigPraffin/dash",global_position,5.0,0.05)
		setVelocity(vel)

func swoopAttack(delta):
	
	var vel = getVelocity()
	vel.y = lerp( vel.y,0.0,0.04 )
	setVelocity(vel)
	move_and_slide()
	
	if vel.y < 15.0:
		state = 0
		swoopWait = -40

func chase(delta):
	
	if healthcomponent.getHealthPercent() > 0.20:
		chaseTicks += 1
	else:
		healthcomponent.defense = 0
	
	velocity = lerp( velocity, getExactDirToPlayer()*200.0, 0.01 )
	
	if dashWhileChaseTicks >= 120:
		velocity = getExactDirToPlayer()*300.0
		dashWhileChaseTicks = 0
		SoundManager.playSound("enemy/boss/bigPraffin/dash",global_position,5.0,0.05)
	dashWhileChaseTicks += 1
	
	move_and_slide()
	
	if chaseTicks > 390:
		chaseTicks = 0
		state = 0

func moveToSettle(delta):
	var pos = settle - global_position
	
	velocity = lerp( velocity, pos, 0.2 )
	move_and_slide()
	
	if velocity.length() < 16.0:
		state = 4

func determineSettlePosition():
	var v = global_position
	if groundRay.is_colliding():
		v = groundRay.get_collision_point()
	
	return v + Vector2(0,-16).rotated( getWorldRot(self) )

func spawnPraffins(delta):
	spawningTicks += 1
	
	if spawningTicks % 40 == 0:
		var ins = praffinScene.instantiate()
		ins.position = position + Vector2(0,-16).rotated( getWorldRot(self) )
		var r = ((randi() % 2) * 2) - 1
		ins.velocity = Vector2( r * 60.0,-200 ).rotated( getWorldRot(self) )
		ins.planet = planet
		get_parent().add_child(ins)
	
	if spawningTicks > 200:
		spawningTicks = 39
		state = 2
		healthcomponent.damageTypeImmunities = []
