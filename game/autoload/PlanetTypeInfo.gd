extends Node


var data = {
	"forest":load("res://world_scenes/planetTypes/ForestType.tres"),
}

func getData(planetType:String):
	if data.has(planetType):
		return data[planetType]
	return data["forest"]
