extends Button

@export var buttonText :String = "text"

var focused :bool= false

func _ready():
	
	$shadow.text = buttonText
	$Node2D/text.text = buttonText
	
	size = $shadow.size

func _process(delta):
	size = $shadow.size
	if focused:
		$Node2D.position = lerp($Node2D.position,Vector2(2,-2),0.2)
	else:
		$Node2D.position = lerp($Node2D.position,Vector2(0,0),0.2)

func _on_mouse_entered():
	focused = true


func _on_mouse_exited():
	focused = false
