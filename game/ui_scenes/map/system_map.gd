extends Node2D

var mapDot = preload("res://ui_scenes/map/map_dot.tscn")

func map(system,cosmos):
	
	for child in get_children():
		child.queue_free()
	
	for obj in cosmos:
		var ins = mapDot.instantiate()
		ins.tiedNode = obj
		if obj == system.rootPlanet:
			ins.modulate = Color.WEB_GREEN
		ins.rootNode = system.rootPlanet
		add_child(ins)
	for obj in system.objectContainer.get_children():
		var ins = mapDot.instantiate()
		ins.tiedNode = obj
		ins.rootNode = system.rootPlanet
		if obj == GlobalRef.player:
			ins.modulate = Color.RED
		add_child(ins)
