extends Node

var loadedFile = "save1"


# handles save files
# static save files, save1, save2, save3

func _ready():
	pass

func read_save(key): # returns dictionary or null
	if OS.has_feature('web'):
		var JSONstr = JavaScriptBridge.eval("window.localStorage.getItem('" + key + "');")
		if (JSONstr):
			return JSON.parse_string(JSONstr)
		else:
			return null
	else:
		var file = FileAccess.open("user://" + key + ".sdata", FileAccess.READ)
		if not file:
			return null
		var newData = JSON.parse_string(file.get_as_text())
		file.close()
		return newData

func write_save(key,data):
	if OS.has_feature('web'):
		JavaScriptBridge.eval("window.localStorage.setItem('" + key + "', '" + JSON.stringify(data) + "');")
	else:
		var file = FileAccess.open("user://" + key + ".sdata", FileAccess.WRITE)
		file.store_line(JSON.stringify(data))
		file.close()

func clearSave(key):
	
	if OS.has_feature('web'):
		var JSONstr = JavaScriptBridge.eval("window.localStorage.getItem('" + key + "');")
		if (JSONstr):
			JavaScriptBridge.eval("window.localStorage.removeItem('" + key + "');")
		else:
			return null
	else:
		var file = FileAccess.open("user://" + key + ".sdata", FileAccess.READ)
		if not file:
			return null
		file.close()
		var dir = DirAccess.open("user://")
		dir.remove(key + ".sdata")
	
func open_site(url):
	if OS.has_feature('web'):
		JavaScriptBridge.eval("window.open(\"" + url + "\");")
	else:
		print("Could not open site " + url + " without an HTML5 build")

func switchToSite(url):
	if OS.has_feature('web'):
		JavaScriptBridge.eval("window.open(\"" + url + "\", \"_parent\");")
	else:
		print("Could not switch to site " + url + " without an HTML5 build")

func has_save(key):
	if OS.has_feature('web'):
		var JSONstr = JavaScriptBridge.eval("window.localStorage.getItem('" + key + "');")
		if (JSONstr):
			return true
		else:
			return false
	else:
		var file = FileAccess.open("user://" + key + ".sdata", FileAccess.READ)
		if not file:
			return false
		return true

func autosave():
	GlobalRef.system.saveGameToFile()
