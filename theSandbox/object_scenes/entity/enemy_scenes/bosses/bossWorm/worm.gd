extends Enemy

@onready var segmentScene = preload("res://object_scenes/entity/enemy_scenes/bosses/bossWorm/worm_segment.tscn")
@onready var eyes = $Eyes
@onready var bodyLine = $Line2D
@onready var segmentContainer = $Segments

@onready var healthcomponent = $HealthComponent # for boss meter

var currentDir :float = 0.0

@export var speeednis :float = 300.0
@export var dotMult :float = 1.0
@export var turnSpeed :float = 0.02

var state :int = 0 # orbit, dash, gear 4

var dashAngle :Vector2 = Vector2.ZERO
var dashTicks :int = 0

func _ready():
	for i in range(40):
		var ins = segmentScene.instantiate()
		ins.hc = $HealthComponent
		segmentContainer.add_child(ins)

func _process(delta):
	var oldPosition = position
	match state:
		0:
			orbit(delta)
		1:
			dash(delta)
	
	eyes.rotation = velocity.angle()
	moveBody(oldPosition,position)

func orbit(delta):
	
	var targetDir :float= getExactDirToPlayer().angle()
	
	currentDir = lerp_angle(currentDir,targetDir,turnSpeed)
	
	var dot = Vector2.from_angle(currentDir).dot( Vector2.from_angle(targetDir) )
	
	var dotty :float= (dot + 1.0) + 0.01
	
	velocity += to_local(GlobalRef.player.global_position) * turnSpeed * dotty
	if velocity.length() > speeednis:
		velocity = velocity.normalized() * speeednis
	
	move_and_slide()
	
	if randi() % 300 == 0:
		enterDashState()
	if healthComp.getHealthPercent() < 0.2:
			enterDashRandom()

func dash(delta):
	velocity = dashAngle.normalized() * 300
	move_and_slide()
	
	dashTicks -= 1
	if dashTicks <= 0:
		
		state = 0
		if healthComp.getHealthPercent() < 0.2:
			enterDashRandom()


func moveBody(oldPos:Vector2,newPos:Vector2):
	var change :Vector2 = newPos - oldPos
	var previousSegment = self
	bodyLine.clear_points()
	
	bodyLine.add_point(Vector2.ZERO)
	for segment in segmentContainer.get_children():
		segment.position -= change
		
		var segmentSpace :Vector2= segment.global_position - previousSegment.global_position
		if segmentSpace.length() > 24:
			segment.global_position = previousSegment.global_position + (segmentSpace.normalized() * 24)
		
		
		previousSegment = segment
		bodyLine.add_point(segment.position)

func enterDashState():
	dashAngle = to_local(GlobalRef.player.global_position)
	dashTicks = 60
	state = 1

func enterDashRandom():
	var rX = randi_range(-200,200)
	var rY = randi_range(-200,200)
	dashAngle = to_local(GlobalRef.player.global_position + Vector2(rX,rY))
	dashTicks = 40 + (randi() % 40)
	state = 1
