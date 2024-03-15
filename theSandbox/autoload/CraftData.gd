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
	2:{ # wood wall
		"crafts":-13,
		"amount":1,
		"ingredients":[13],
		"ingAmounts":[1],
	},
}

func getCraft(id):
	if data.has(id):
		return data[id]
	return data[0]
