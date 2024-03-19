extends Camera2D

@onready var backgroundHolder = $Backgroundholder
@onready var map = $SystemMap
@onready var mapbg = $ColorRect2

func _ready():
	GlobalRef.camera = self
