extends Node

var data = {
	0:{
		"crafts":2,
		"amount":10,
		"ingredients":[3,7],
		"ingAmounts":[10,1],
	},
	1:{
		"crafts":3,
		"amount":99,
		"ingredients":[7],
		"ingAmounts":[1],
	},
}

func getCraft(id):
	if data.has(id):
		return data[id]
	return data[0]
