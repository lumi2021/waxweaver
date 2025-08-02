extends EnemyAI
class_name FighterAI

@export var gravity := 1000
@export var speed :float= 10

var wasOnWallTicks = 0
var knockedBack :int = 0

var state := 1 # 0 : chase, 1 : wander
var wanderState := 0
var dir := 0
var walkFrame = 0

func onFrame(delta,enemy:CharacterBody2D):
	var quad = getWorldPosition(enemy)
	enemy.up_direction = Vector2(0,-1).rotated(quad*(PI/2))
	var newVel = enemy.velocity.rotated(quad*-(PI/2))
	
	newVel.y += gravity * delta
	
	if knockedBack < 0:
		if enemy.is_on_floor():
			knockedBack -= 1
		enemy.velocity = newVel.rotated(quad*(PI/2))
		enemy.move_and_slide()
		return
	
	var aggro = getAggro()
	if aggro != null:
		
		var enemyQuad = getWorldPosition(aggro)
		
		var pose = enemy.position.rotated((PI/2)*-quad)
		var posa = aggro.position.rotated((PI/2)*-enemyQuad)
		var targetdir :int= (int(pose.x < posa.x) * 2.0) - 1.0
		
		if enemyQuad != quad:
			targetdir *= -1
		if state == 1:
			if randi() % 60 == 0:
				var newState = (randi() % 3) - 1
				wanderState = newState
			targetdir *= wanderState
		
		dir = targetdir
		anim(enemy)
		
		var mult = (2 - state) * 0.5
		
		if enemy.is_on_floor():
			newVel.x = lerp(newVel.x,speed * targetdir * mult,0.05)
				
			if enemy.is_on_wall():
				newVel.y = -250
				wasOnWallTicks = 6
			
			var dis = abs(pose.x - posa.x)
			var ydis = abs(pose.y - posa.y)
			if dis < 24 and ydis < 48:
				newVel.y = -250
				newVel.x += targetdir * 10.0
				if enemyQuad == quad:
					state = 0
					
			
		
		elif wasOnWallTicks > 0:
			wasOnWallTicks -= 1
			newVel.x = lerp(newVel.x,speed * targetdir,0.5)
		
	
		
	enemy.velocity = newVel.rotated(quad*(PI/2))
	enemy.move_and_slide()
	
	
	
func onHit(enemy):
	knockedBack = 10
	state = 0
 
func onDeath(enemy):
	pass

func onSpawn(enemy):
	pass

func getWorldPosition(enemy):
	var angle1 = Vector2(1,1)
	var angle2 = Vector2(-1,1)
		
	var dot1 = int(enemy.position.dot(angle1) >= 0)
	var dot2 = int(enemy.position.dot(angle2) > 0) * 2
	
	
	
	return [0,1,3,2][dot1 + dot2]

func anim(e):
	
	if !e.is_on_floor():
		frame = 3
		return
	
	match dir:
		0:
			frame = 0
			walkFrame = 0
		1:
			flipped = false
			walkAnim()
		-1:
			flipped = true
			walkAnim()
	
func walkAnim():
	if walkFrame >= 40:
		walkFrame = 0
	match walkFrame:
		0:
			frame = 1
		10:
			frame = 0
		20:
			frame = 2
		30:
			frame = 0
	walkFrame += 1
