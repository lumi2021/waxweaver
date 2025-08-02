extends Enemy

var dead :bool= false

func _ready():
	$start.emitting = true
	
	var status = StatusInflictor.new()
	var r = randi() % 6
	match r:
		0:
			status.effectName = "poison"
			status.seconds = "30"
		1:
			status.effectName = "burning"
			status.seconds = "30"
		2:
			status.effectName = "fragile"
			status.seconds = "15"
		3:
			status.effectName = "confused"
			status.seconds = "10"
		4:
			status.effectName = "frozen"
			status.seconds = "5"
			GlobalRef.playerGravityOverride = -1
		5:
			status.effectName = "wet"
			status.seconds = "15"
	$Hurtbox.statusInflictors.append(status)

func _process(delta):
	if dead:
		return
	var vel = getVelocity()
	vel.y += 800 * delta
	setVelocity(vel)
	var c = move_and_collide(velocity * delta)
	
	if c:
		startDelete()

func startDelete():
	dead = true
	$flame.emitting = false
	$end.emitting = true
	$Hurtbox/CollisionShape2D.call_deferred("set_disabled",true)


func _on_end_finished():
	queue_free()


func _on_hurtbox_hitsomething():
	startDelete()
