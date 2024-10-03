extends Item
class_name ItemPlant

@export var blockToPlace :int
@export var acceptableBlocks :Array[int]

@export var descCanPlaceOn :String = "my balls"

func onUse(tileX:int,tileY:int,planetDir:int,planet,lastTile:Vector2):
	
	if planet == null:
		#Cancel if not on planet
		return
	
	var block = planet.DATAC.getTileData(tileX,tileY)
	
	if block > 1:
		#Cancel is target tile isn't empty
		return
	
	# scan downwards
	var dir = planet.DATAC.getPositionLookup(tileX,tileY)
	var down = Vector2i( Vector2(0,1).rotated(dir*(PI/2)) ) + Vector2i(tileX,tileY)
	
	var blockBelow = planet.DATAC.getTileData(down.x,down.y)
	
	if !acceptableBlocks.has(blockBelow):
		return # fail if acceptable block doesn't exist
	
	var edit = Vector2i(tileX,tileY)
	planet.editTiles({edit:blockToPlace})
	playSound(tileX,tileY,planet)
	PlayerData.consumeSelected()

func playSound(tileX:int,tileY:int,planet):
	var s = SoundManager.getMineSound(blockToPlace)
	var p = GlobalRef.player.global_position
	SoundManager.playSoundStream( s,p, SoundManager.blockPlaceVol, 0.1,"BLOCKS" )
