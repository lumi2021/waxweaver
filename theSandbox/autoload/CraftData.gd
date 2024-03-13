extends Node

var data = {
	0:{
		"crafts":2,
		"amount":10,
		"ingredients":[3,7],
		"ingAmounts":[10,1],
	},

}

func getCraft(id):
	if data.has(id):
		return data[id]
	return data[0]
