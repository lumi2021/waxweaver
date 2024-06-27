extends Node

enum {FURNACE = 16, WORKBENCH = 20}

var data = {
	# might get messy BE CAREFUL
	
	0:{ # wood wall
		"crafts":-13,
		"amount":4,
		"ingredients":[13],
		"ingAmounts":[1],
		"station":WORKBENCH,
	},
	
	1:{ # torch
		"crafts":15,
		"amount":3,
		"ingredients":[13,3003],
		"ingAmounts":[1,1],
	},
	
	2:{ # furnace
		"crafts":16,
		"amount":1,
		"ingredients":[2,15],
		"ingAmounts":[10,6],
		"station":WORKBENCH,
	},
	
	3:{ # wooden chair
		"crafts":6000,
		"amount":1,
		"ingredients":[13],
		"ingAmounts":[5],
		"station":WORKBENCH,
	},
	
	4:{ # glass
		"crafts":21,
		"amount":1,
		"ingredients":[14],
		"ingAmounts":[1],
		"station":FURNACE,
	},
	
	5:{ # glass wall
		"crafts":-21,
		"amount":4,
		"ingredients":[21],
		"ingAmounts":[1],
		"station":WORKBENCH,
	},
	
	6:{ # copper ingot
		"crafts":3004,
		"amount":1,
		"ingredients":[18],
		"ingAmounts":[3],
		"station":FURNACE,
	},
	
}

func getCraft(id):
	if data.has(id):
		return data[id]
	return data[0]

func _ready():
	initializeMaterials()

func initializeMaterials():
	for recipe in data:
		for materialID in data[recipe]["ingredients"]:
			ItemData.data[materialID].materialIn.append(recipe)
	
