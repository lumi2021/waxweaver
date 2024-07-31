extends Node

enum {FURNACE = 16, WORKBENCH = 20}

var data = [
	# might get messy BE CAREFUL
	
	## STATION-LESS RECIPIES ##
	{ # torch
		"crafts":15,
		"amount":3,
		"ingredients":[13,3003],
		"ingAmounts":[1,1],
	},
	
	{ # ladder
		"crafts":25,
		"amount":3,
		"ingredients":[13],
		"ingAmounts":[1],
	},
	
	{ # workbench
		"crafts":20,
		"amount":1,
		"ingredients":[13],
		"ingAmounts":[10],
	},
	
	## WALLS ##
	
	{ # wood wall
		"crafts":-13,
		"amount":4,
		"ingredients":[13],
		"ingAmounts":[1],
		"station":WORKBENCH,
	},
	
	{ # glass wall
		"crafts":-21,
		"amount":4,
		"ingredients":[21],
		"ingAmounts":[1],
		"station":WORKBENCH,
	},
	
	## FURNITURE ##
	{ # furnace
		"crafts":16,
		"amount":1,
		"ingredients":[2,15],
		"ingAmounts":[10,6],
		"station":WORKBENCH,
	},
	
	{ # wooden chair
		"crafts":6000,
		"amount":1,
		"ingredients":[13],
		"ingAmounts":[5],
		"station":WORKBENCH,
	},
	
	{ # wooden door
		"crafts":6200,
		"amount":1,
		"ingredients":[13],
		"ingAmounts":[3],
		"station":WORKBENCH,
	},
	
	## BLOCKS ##
	
	{ # glass
		"crafts":21,
		"amount":1,
		"ingredients":[14],
		"ingAmounts":[1],
		"station":FURNACE,
	},
	
	## INGOTS ##
	{ # copper ingot
		"crafts":3004,
		"amount":1,
		"ingredients":[18],
		"ingAmounts":[3],
		"station":FURNACE,
	},
	
	{ # gold ingot
		"crafts":3005,
		"amount":1,
		"ingredients":[24],
		"ingAmounts":[3],
		"station":FURNACE,
	},
	
	
	## TOOLS ##
	{ # copper sword
		"crafts":3006,
		"amount":1,
		"ingredients":[3004,13],
		"ingAmounts":[5,5],
		"station":WORKBENCH,
	},
	
	{ # copper pickaxe
		"crafts":3007,
		"amount":1,
		"ingredients":[3004,13],
		"ingAmounts":[5,5],
		"station":WORKBENCH,
	},
	{ # gold sword
		"crafts":3008,
		"amount":1,
		"ingredients":[3005,13],
		"ingAmounts":[5,5],
		"station":WORKBENCH,
	},
	
	{ # gold pickaxe
		"crafts":3009,
		"amount":1,
		"ingredients":[3005,13],
		"ingAmounts":[5,5],
		"station":WORKBENCH,
	},
	
]

func getCraft(id):
	if id < data.size():
		return data[id]
	return data[0]

func _ready():
	initializeMaterials()

func initializeMaterials():
	var id = 0
	for recipe in data:
		for materialID in data[id]["ingredients"]:
			ItemData.data[materialID].materialIn.append(id)
		id += 1
	
