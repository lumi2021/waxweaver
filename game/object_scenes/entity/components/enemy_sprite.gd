extends Sprite2D
class_name EnemySprite

func _process(delta):
	
	rotation = lerp_angle(rotation,(PI/2)*getWorldPosition(),0.2)

func getWorldPosition():
	var angle1 = Vector2(1,1)
	var angle2 = Vector2(-1,1)
		
	var dot1 = int(get_parent().position.dot(angle1) >= 0)
	var dot2 = int(get_parent().position.dot(angle2) > 0) * 2
	
	return [0,1,3,2][dot1 + dot2]
