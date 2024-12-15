extends Node2D

@onready var parent = get_parent()

func _process(delta):
	visible = !get_tree().paused
	if get_tree().paused:
		return
	
	#global_position = get_global_mouse_position()
	rotation = GlobalRef.camera.rotation
	
	if parent.get_local_mouse_position().length() > 48:
		$RightClick.visible = false
		return
	var editBody = parent.getEditingBody()
	if !is_instance_valid(editBody):
		return
	var mousePos = editBody.get_local_mouse_position()
	var tile = editBody.posToTile(mousePos)
	if tile == null:
		return
	var blockType = editBody.DATAC.getTileData(tile.x,tile.y)
	$RightClick.visible = [19,22,23,25,33,34,47,48,55,62,63,97,98,99,100,101,102].has(blockType)
	
func onRightClick():
	
	#cancel if out of range
	if parent.get_local_mouse_position().length() > 48:
		return
	
	var editBody = parent.getEditingBody()
	if !is_instance_valid(editBody):
		return
	
	var mousePos = editBody.get_local_mouse_position()
	var tile = editBody.posToTile(mousePos)
	var blockType = editBody.DATAC.getTileData(tile.x,tile.y)
	var rot = editBody.DATAC.getPositionLookup(tile.x,tile.y)
	
	
	# right click functionality for each block
	match blockType:
		19: # chair
			
			# return if wall is in the way
			if !parent.wallCheck(get_local_mouse_position()):
				return
			
			if parent.rotated != editBody.DATAC.getPositionLookup(tile.x,tile.y) and editBody is Planet:
				return
			parent.movementState = 1 # enter chair state
			parent.chairSit(tile,editBody)
		22: # closed door
			parent.openDoor(tile,editBody,GlobalRef.playerSide)
			SoundManager.playSound("interacts/door",get_global_mouse_position(),1.2,0.1)
		23: # open door
			parent.closeDoor(tile,editBody)
			SoundManager.playSound("interacts/door",get_global_mouse_position(),1.2,0.1)
		25: # ladder
			
			# return if wall is in the way
			if !parent.wallCheck(parent.get_local_mouse_position()):
				return
			
			if parent.lastOnLadder > 0: # return if player was on a ladder recently
				return
			
			if parent.movementState == 2:
				return
			parent.movementState = 2 # enter ladder state
			if editBody is Planet:
				parent.rotated = editBody.DATAC.getPositionLookup(tile.x,tile.y)
			parent.attachToLadder(tile,editBody)
			SoundManager.playSound("items/ladderClimb",parent.global_position,1.5,0.1)

		33: # chest 
			if PlayerData.chestOBJ == editBody and PlayerData.currentSelectedChest == tile:
				PlayerData.closeChest()
				return
			
			if PlayerData.loadChest(editBody,tile):
				# chest visual
				var ins = load("res://object_scenes/chest/chest_open.tscn").instantiate()
				ins.position = editBody.tileToPos(tile)
				ins.body = editBody
				ins.pos = tile
				ins.rot = rot
				editBody.entityContainer.add_child(ins)
				SoundManager.playSound("interacts/chest",get_global_mouse_position(),1.0,0.1)
		34: # loot chest
			
			GlobalRef.playerHasInteractedWithChest = true
			editBody.chestDictionary[tile] = LootData.getChestLoot(editBody.planetType)
			editBody.DATAC.setTileData(tile.x,tile.y,33)
			
			if PlayerData.loadChest(editBody,tile):
				# chest visual
				var ins = load("res://object_scenes/chest/chest_open.tscn").instantiate()
				ins.position = editBody.tileToPos(tile)
				ins.body = editBody
				ins.pos = tile
				ins.rot = rot
				editBody.entityContainer.add_child(ins)
				SoundManager.playSound("interacts/chest",get_global_mouse_position(),1.0,0.1)
		47: # trap door
			var dick = parent.setAllTrapdoors(tile,48,editBody)
			editBody.editTiles( dick )
			SoundManager.playSound("interacts/door",get_global_mouse_position(),1.2,0.1)
		48: # trap door
			var dick = parent.setAllTrapdoors(tile,47,editBody)
			editBody.editTiles( dick )
			SoundManager.playSound("interacts/door",get_global_mouse_position(),1.2,0.1)
		55: # bed
			
			if editBody is Ship:
				GlobalRef.sendChat("You can't sleep on a ship!")
				return # fix laying on bed in ship
			else:
				GlobalRef.playerSpawn = editBody.tileToPos(tile)
				GlobalRef.playerSpawnPlanet = editBody
				GlobalRef.sendChat("Set spawnpoint.")
			
			parent.movementState = 3
			parent.position = editBody.tileToPos(tile)
			var info = editBody.DATAC.getInfoData(tile.x,tile.y) % 4
			var d = editBody.DATAC.getPositionLookup(tile.x,tile.y)
			
			var side = (int( info < 2 )*2) - 1 # is 1 or -1 
			
			parent.flipPlayer( side )
			parent.sprite.rotation = (side * -(PI/2)) + ( d * (PI/2) )
			
			if info == 0:
				parent.position += Vector2(8,0).rotated(d * (PI/2))
			elif info == 3:
				parent.position += Vector2(-8,0).rotated(d * (PI/2))
			
			parent.position += Vector2(-side,-3).rotated(d * (PI/2))
		62: # letter block
			var currentLetter = editBody.DATAC.getInfoData(tile.x,tile.y)
			currentLetter = (currentLetter + 1) % 38
			editBody.DATAC.setInfoData(tile.x,tile.y,currentLetter)
			editBody.editTiles( { Vector2i(tile.x,tile.y):62, } )
		63: # ship boss pedastal
			if PlayerData.checkForIngredient(3076,1):
				if CreatureData.spawnBoss(parent.planetOn,parent.position + Vector2(0,-250).rotated(parent.rotated*(PI/2)) ,"bossShip"):
					GlobalRef.sendChat("Summoned big praffin!!")
					PlayerData.consumeItems([3076],[1])
					PlayerData.emit_signal("updateInventory")
			else:
				GlobalRef.sendChat("i need a wax lollipop!!")
		97: # lever
			var info :int= editBody.DATAC.getInfoData( tile.x, tile.y )
			
			var scan :Vector2i = Vector2i( Vector2( 1,0 ).rotated( (info/2) * (PI/2) ))
			
			var tileBelowLever = editBody.DATAC.getTileData( scan.x + tile.x, scan.y + tile.y )
			if tileBelowLever == 91 or tileBelowLever == 93:
				var d = editBody.DATAC.energize( tile.x, tile.y, editBody, BlockData.getLookup() )
				editBody.editTiles( d )
			else:
				var d = editBody.DATAC.energize( scan.x + tile.x, scan.y + tile.y , editBody, BlockData.getLookup() )
				editBody.editTiles( d )
			
			var flip := info % 2
			editBody.DATAC.setInfoData( tile.x, tile.y, ((info/2)*2) + abs(1-flip) )
			editBody.editTiles( {Vector2i(tile.x, tile.y):97} )
		98: # observer
			var info :int= editBody.DATAC.getInfoData( tile.x, tile.y )
			var target = (info + 2) % 8
			editBody.DATAC.setInfoData( tile.x, tile.y, target )
			editBody.editTiles( {Vector2i(tile.x, tile.y):98} )
		99: # clock trigger
			var info :int= editBody.DATAC.getInfoData( tile.x, tile.y )
			var target = (info + 1) % 8
			editBody.DATAC.setInfoData( tile.x, tile.y, target )
			print(target)
			match target:
				0:
					GlobalRef.sendChat("clock set to 1 second")
				1:
					GlobalRef.sendChat("clock set to 0.5 seconds")
				2:
					GlobalRef.sendChat("clock set to 0.33 seconds")
				3:
					GlobalRef.sendChat("clock set to once per tick")
				4:
					GlobalRef.sendChat("clock set to 2 seconds")
				5:
					GlobalRef.sendChat("clock set to 5 seconds")
				6:
					GlobalRef.sendChat("clock set to 10 seconds")
				7:
					GlobalRef.sendChat("clock set to 30 seconds")
		100:
			var info :int= editBody.DATAC.getInfoData( tile.x, tile.y )
			var target = (info + 2) % 8
			editBody.DATAC.setInfoData( tile.x, tile.y, target )
			editBody.editTiles( {Vector2i(tile.x, tile.y):100} )
		101:
			var info :int= editBody.DATAC.getInfoData( tile.x, tile.y )
			var target = (info + 1) % 4
			editBody.DATAC.setInfoData( tile.x, tile.y, target )
			editBody.editTiles( {Vector2i(tile.x, tile.y):101} )
		102:
			var info :int= editBody.DATAC.getInfoData( tile.x, tile.y )
			var target = (info + 1) % 4
			editBody.DATAC.setInfoData( tile.x, tile.y, target )
			editBody.editTiles( {Vector2i(tile.x, tile.y):102} )
