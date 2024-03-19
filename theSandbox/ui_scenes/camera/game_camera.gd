extends Camera2D

@onready var backgroundHolder = $Backgroundholder
@onready var map = $SystemMap
@onready var mapbg = $ColorRect2
@onready var compass = $Compass

func _ready():
	GlobalRef.camera = self

func cpass(motion):
	compass.rotation = -rotation
	if motion.length() > 1000:
		$speedPart.rotation = -rotation + motion.angle() + (PI/2)
		$speedPart.emitting = true
		
		$speedPart.scale_amount_max = clamp(motion.length()/2500.0,0,1.0)
		$speedPart.scale_amount_min = $speedPart.scale_amount_max
	else:
		$speedPart.emitting = false
