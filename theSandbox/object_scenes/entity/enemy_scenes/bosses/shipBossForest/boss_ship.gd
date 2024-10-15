extends Enemy

var state :int= 0
## states:
# 0: position for swoop attack
# 1: swoop attack

var swoopSide = 0
var swoopWait :int= 0

func _ready():
	$axis/AnimatedSprite2D.play("default")

func _physics_process(delta):
	match state:
		0:
			position4swoopAttack(delta)
		1:
			swoopAttack(delta)
	
	# sprite rotation
	$axis/AnimatedSprite2D.rotation = getVelocity().x * 0.001

func position4swoopAttack(delta):
	if swoopSide == 0:
		swoopSide = ((randi() % 2) * 2) - 1 # gets either -1 or 1
	
	var targetPosition = GlobalRef.player.position + Vector2(128*swoopSide,-128).rotated(getWorldRot(self))
	velocity = lerp(velocity,position.direction_to( targetPosition ) * 200.0,0.04)
	move_and_slide()
	
	swoopWait += 1
	
	if swoopWait > 120:
		state = 1
		swoopSide *= -1
		var vel = Vector2(200*swoopSide,410)
		setVelocity(vel)

func swoopAttack(delta):
	
	var vel = getVelocity()
	vel.y = lerp( vel.y,0.0,0.04 )
	setVelocity(vel)
	move_and_slide()
	
	if vel.y < 15.0:
		state = 0
		swoopWait = -40
