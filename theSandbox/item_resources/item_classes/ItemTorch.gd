extends Item
class_name ItemTorch

@export var blockID := 0


func onUse(tileX:int,tileY:int,planetDir:int,planet,lastTile:Vector2):
	
	if planet == null:
		#Cancel if not on planet
		return "failure"
	
	var block = planet.DATAC.getTileData(tileX,tileY)
	
	if ![0,1].has(block):
		#Cancel is target tile isn't empty
		return "failure"
	
	# check down
	var d = Vector2(0,1).rotated((PI/2)*planetDir)
	var downTile = Vector2(tileX,tileY) + Vector2(int(d.x),int(d.y))
	if getBlockIsSolid(planet.DATAC.getTileData(downTile.x,downTile.y)):
		var edit = Vector2i(tileX,tileY)
		planet.DATAC.setInfoData(tileX,tileY,1)
		planet.editTiles({edit:blockID},true)
		PlayerData.consumeSelected()
		playSound(tileX,tileY,planet)
		return "success"
	
	# check sides
	var r = Vector2(1,0).rotated((PI/2)*planetDir)
	var rightTile = Vector2(tileX,tileY) + Vector2(int(r.x),int(r.y))
	if getBlockIsSolid(planet.DATAC.getTileData(rightTile.x,rightTile.y)):
		var edit = Vector2i(tileX,tileY)
		planet.DATAC.setInfoData(tileX,tileY,2)
		planet.editTiles({edit:blockID},true)
		PlayerData.consumeSelected()
		playSound(tileX,tileY,planet)
		return "success"
	
	var l = Vector2(-1,0).rotated((PI/2)*planetDir)
	var leftTile = Vector2(tileX,tileY) + Vector2(int(l.x),int(l.y))
	if getBlockIsSolid(planet.DATAC.getTileData(leftTile.x,leftTile.y)):
		var edit = Vector2i(tileX,tileY)
		planet.DATAC.setInfoData(tileX,tileY,3)
		planet.editTiles({edit:blockID},true)
		PlayerData.consumeSelected()
		playSound(tileX,tileY,planet)
		return "success"
	
	
	# check for bg wall
	var bg = planet.DATAC.getBGData(tileX,tileY)
	if ![0,1].has(bg):
		var edit = Vector2i(tileX,tileY)
		planet.editTiles({edit:blockID},true)
		planet.DATAC.setInfoData(tileX,tileY,0)
		PlayerData.consumeSelected()
		playSound(tileX,tileY,planet)
		return "success"

func getBlockIsSolid(id):
	var collider = BlockData.theChunker.getBlockDictionary(id)["hasCollision"]
	if id == 8:
		collider = true
	if id == 56:
		collider = true
	if id == 116:
		collider = true
	
	return collider

func playSound(tileX:int,tileY:int,planet):
	var s = SoundManager.getMineSound(blockID)
	var p = GlobalRef.player.global_position
	SoundManager.playSoundStream( s,p,SoundManager.blockPlaceVol, 0.1,"BLOCKS" )
