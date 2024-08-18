extends Node
class_name HealthComponent

## COOL EXPORTS ##
#self explanitory
@export var maxHealth :int= 100
var health :int= 0
# simple knockback multiplier
@export var knockbackResist :float = 1.0
@export var defense :int = 0

## list of items enemy will drop
@export var dropItemArray :Array[int]= []
## list of chances above items have to drop, make sure this is same size
@export var dropChanceArray :Array[int]= []


@onready var parent = get_parent()
@export var isPlayer :bool = false

signal healthChanged
signal smacked


# status stuff
var speedMult :float= 1.0


func _ready():
	health = maxHealth

func heal(amount):
	health += amount
	health = min(health,maxHealth)
	
	if isPlayer:
		Indicators.damnPopup(amount,parent.global_position,"healPlayer")
	else:
		Indicators.damnPopup(amount,parent.global_position,"heal")
	
	emit_signal("healthChanged")

func damage(amount):
	
	if isPlayer:
		if parent.dead:
			return
	
	var trueAmount = amount
	trueAmount -= defense
	trueAmount = max(trueAmount,1)
	
	health -= trueAmount
	
	health = max(health,0)
	
	if isPlayer:
		Indicators.damnPopup(trueAmount,parent.global_position,"player")
	else:
		Indicators.damnPopup(trueAmount,parent.global_position)
	
	emit_signal("healthChanged")
	emit_signal("smacked")
	
	if health <= 0:
		die()

func dealKnockback(amount:float,dir:Vector2,mult:float):
	var q = getWorldPosition()
	dir = dir.rotated(-q*(PI/2)).normalized()
	var b = (int(dir.x > 0.0) * 2) - 1
	var newDir = Vector2(amount * b * mult,amount * -2 * sqrt(mult))
	newDir = newDir.rotated(q*(PI/2))
	
	if knockbackResist > 0.0:
		parent.velocity = newDir * knockbackResist
	if isPlayer:
		parent.beingKnockedback = true
	
func die():
	if isPlayer:
		parent.dieAndRespawn()
		return
	
	rollDrops()
	CreatureData.creatureDeleted(parent)

func getWorldPosition():
	var angle1 = Vector2(1,1)
	var angle2 = Vector2(-1,1)
		
	var dot1 = int(parent.position.dot(angle1) >= 0)
	var dot2 = int(parent.position.dot(angle2) > 0) * 2
	
	
	return [0,1,3,2][dot1 + dot2]

func rollDrops():
	if dropItemArray.size() != dropChanceArray.size():
		print_debug("Drop array and chance array do not match: " + str(parent))
		return
	
	var i = 0
	for drop in dropItemArray:
		
		if randi() % dropChanceArray[i] == 0:
			dropItem(drop)
		
		i += 1


func dropItem(itemID):
	if itemID == -1:
		return
	var ins = BlockData.groundItemScene.instantiate()
	ins.itemID = itemID
	ins.position = parent.position
	parent.get_parent().call_deferred("add_child",ins)
