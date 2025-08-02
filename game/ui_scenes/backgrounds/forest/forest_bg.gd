extends Node2D

func _ready():
	GlobalRef.connect("changeEvilState",brap)

func _process(delta):
	if GlobalRef.bossEvil:
		$backgroundLayer.scroll(Vector2(1000*delta,0))
	else:
		$backgroundLayer.scroll(Vector2(30*delta,0))

func brap():
	if GlobalRef.bossEvil:
		$backgroundLayer.modulate = Color.BLACK
		$backgroundLayer.modulate.a = 0.5
	else:
		$backgroundLayer.modulate = Color(0.369,0.812,1.0,0.082)

