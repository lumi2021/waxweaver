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
	
	###########
	## WALLS ##
	###########
	
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
	
	{ # stone brick wall
		"crafts":-32,
		"amount":4,
		"ingredients":[32],
		"ingAmounts":[1],
		"station":WORKBENCH,
	},
	
	###############
	## FURNITURE ##
	###############
	
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
		"crafts":6050,
		"amount":1,
		"ingredients":[13],
		"ingAmounts":[3],
		"station":WORKBENCH,
	},
	
	{ # wood chest
		"crafts":6100,
		"amount":1,
		"ingredients":[13],
		"ingAmounts":[6],
		"station":WORKBENCH,
	},
	
	############
	## BLOCKS ##
	############
	
	{ # glass
		"crafts":21,
		"amount":1,
		"ingredients":[14],
		"ingAmounts":[1],
		"station":FURNACE,
	},
	
	{ # stone brick
		"crafts":32,
		"amount":1,
		"ingredients":[2],
		"ingAmounts":[1],
		"station":FURNACE,
	},
	
	############
	## INGOTS ##
	############
	
	{ # copper ingot
		"crafts":29,
		"amount":1,
		"ingredients":[18],
		"ingAmounts":[1],
		"station":FURNACE,
	},
	
	{ # gold ingot
		"crafts":30,
		"amount":1,
		"ingredients":[24],
		"ingAmounts":[1],
		"station":FURNACE,
	},
	
	{ # iron ingot
		"crafts":31,
		"amount":1,
		"ingredients":[27],
		"ingAmounts":[1],
		"station":FURNACE,
	},
	
	###########
	## TOOLS ##
	###########
	
	{ # mallet hammer
		"crafts":3002,
		"amount":1,
		"ingredients":[3003,13],
		"ingAmounts":[5,5],
		"station":WORKBENCH,
	},
	
	{ # copper sword
		"crafts":3006,
		"amount":1,
		"ingredients":[29,13],
		"ingAmounts":[5,5],
		"station":WORKBENCH,
	},
	
	{ # copper pickaxe
		"crafts":3007,
		"amount":1,
		"ingredients":[29,13],
		"ingAmounts":[5,5],
		"station":WORKBENCH,
	},
	{ # gold sword
		"crafts":3008,
		"amount":1,
		"ingredients":[30,13],
		"ingAmounts":[8,5],
		"station":WORKBENCH,
	},
	
	{ # gold pickaxe
		"crafts":3009,
		"amount":1,
		"ingredients":[30,13],
		"ingAmounts":[8,5],
		"station":WORKBENCH,
	},
	{ # iron sword
		"crafts":3011,
		"amount":1,
		"ingredients":[31,13],
		"ingAmounts":[15,5],
		"station":WORKBENCH,
	},
	
	{ # iron pickaxe
		"crafts":3012,
		"amount":1,
		"ingredients":[31,13],
		"ingAmounts":[15,5],
		"station":WORKBENCH,
	},
	
	###########
	## ARMOR ##
	###########
	
	{ # copper helmet
		"crafts":3013,
		"amount":1,
		"ingredients":[29],
		"ingAmounts":[10],
		"station":WORKBENCH,
	},
	
	{ # copper chest
		"crafts":3014,
		"amount":1,
		"ingredients":[29],
		"ingAmounts":[10],
		"station":WORKBENCH,
	},
	
	{ # copper legs
		"crafts":3015,
		"amount":1,
		"ingredients":[29],
		"ingAmounts":[10],
		"station":WORKBENCH,
	},
	{ # golden helmet
		"crafts":3016,
		"amount":1,
		"ingredients":[30],
		"ingAmounts":[10],
		"station":WORKBENCH,
	},
	
	{ # golden chest
		"crafts":3017,
		"amount":1,
		"ingredients":[30],
		"ingAmounts":[10],
		"station":WORKBENCH,
	},
	
	{ # golden legs
		"crafts":3018,
		"amount":1,
		"ingredients":[30],
		"ingAmounts":[10],
		"station":WORKBENCH,
	},
	{ # iron helmet
		"crafts":3019,
		"amount":1,
		"ingredients":[31],
		"ingAmounts":[10],
		"station":WORKBENCH,
	},
	
	{ # iron chest
		"crafts":3020,
		"amount":1,
		"ingredients":[31],
		"ingAmounts":[10],
		"station":WORKBENCH,
	},
	
	{ # iron legs
		"crafts":3021,
		"amount":1,
		"ingredients":[31],
		"ingAmounts":[10],
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
	
