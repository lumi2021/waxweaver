extends Node

var data = {
	# might get messy BE CAREFUL
	
	0:{ # wood wall
		"crafts":-13,
		"amount":4,
		"ingredients":[13],
		"ingAmounts":[1],
	},
	
	1:{ # torch
		"crafts":15,
		"amount":3,
		"ingredients":[13,3003],
		"ingAmounts":[1,1],
	},
	
	2:{ # test table true
		"crafts":16,
		"amount":1,
		"ingredients":[3003],
		"ingAmounts":[20],
	},
	
	3:{ # wooden chair
		"crafts":6000,
		"amount":1,
		"ingredients":[13],
		"ingAmounts":[5],
	},
	
	
}

func getCraft(id):
	if data.has(id):
		return data[id]
	return data[0]
