extends EnemyAI
class_name SlimeAI

@export var gravity := 100

func onFrame(delta,enemy:CharacterBody2D):
	var quad = getWorldPosition(enemy)
	enemy.up_direction = Vector2(0,-1).rotated(quad*(PI/2))
	var newVel = enemy.velocity.rotated(quad*-(PI/2))
	
	newVel.y += gravity * delta
	
	var g = randi_range(-200,200)
	if enemy.is_on_floor():
		newVel.x = lerp(newVel.x,0.0,0.15)
		if abs(g) > 190:
			newVel.x = g * 0.45
			newVel.y = -200
		
	
	enemy.velocity = newVel.rotated(quad*(PI/2))
	enemy.move_and_slide()
	
func onHit(enemy):
	pass

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
