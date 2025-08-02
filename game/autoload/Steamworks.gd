extends Node

func _ready():
	#3599070 - waxweaver
	if !OS.has_feature("web"):
		var initialize_response: Dictionary = Steam.steamInitEx(true,3599070)
		print( initialize_response )
		GlobalRef.steamInitialized = initialize_response["status"] == 0

func unlockmedal(medalID:String):
	Steam.setAchievement(medalID)
	Steam.storeStats()
	print(medalID + " unlcoked on steam!")


