extends Resource
class_name EnemyResource

@export var maxHealth := 100
@export var defense := 0
@export var knockbackResist := 0
@export var attackDamage := 10

## Size of the enemys square world collider. 8 is the same as a tile.
@export var hitboxSize := 6

#copy deez
func onFrame(delta,enemy):
	pass

func onHit(delta,enemy):
	pass

func onDeath(delta,enemy):
	pass

func onSpawn(delta,enemy):
	pass
