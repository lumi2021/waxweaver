extends CharacterBody2D
class_name Player


@export var system : Node2D

@onready var sprite = $PlayerLayers
@onready var animationPlayer = $AnimationPlayer
@onready var cameraOrigin = $CameraOrigin

@onready var shipDEBUG = preload("res://world_scenes/ship/ship.tscn")

var rotated = 0
var rotationDelayTicks = 0

var gravity = 1000

var previousChunk = Vector2.ZERO

var planetOn :Node2D = null
var shipOn :Node2D = null
##States: 0 = ON PLANET, 1 = ON SHIP IN SPACE, 
##      2 = ON SHIP ON PLANET, 3 = IN SPACE
var state = 0 

## States: 0 = REGULAR, 1 = SITTING, 2 = LADDER
var movementState = 0

var animTick = 0
var ladderTick = 0
var maxCameraDistance := 0

var lastTileItemUsedOn := Vector2(-10,-10)

var noClip = false
var noClipSpeed = 200

var tick = 0
var blinkTick = 0

var beingKnockedback = false

var wasInWater = false

@onready var itemRoot = $itemWorldRotation/heldItemRoot
var heldItemAnim :itemHeldClass = null

## armors
@onready var helmetSpr = $PlayerLayers/helmet
@onready var chestSpr = $PlayerLayers/chestplate
@onready var legsSpr = $PlayerLayers/leggings

######################################################################
########################### BASIC FUNTIONS ###########################
######################################################################


func _ready():
	GlobalRef.player = self
	PlayerData.connect("selectedSlotChanged",swapSlot)
	PlayerData.connect("armorUpdated",changeArmor)
	
	PlayerData.addItem(3000,1)
	PlayerData.addItem(3001,1)
	
	PlayerData.selectSlot(0)

func _process(delta):
	
	tick+=1
	
	match state:
		0: #On planet
			z_index = 0
			determineMovementState(delta)
			findShipToAttachTo()
			detachFromPlanetToSpace()
		1: #On ship in space
			z_index = 1
			if detachFromShip(): return
			determineMovementState(delta)
			findPlanetToAttachInShip()
		2: # On ship on planet
			z_index = 1
			determineMovementState(delta)
			detachFromShip()
			shipDetachFromPlanet()
		3: # In space
			z_index = 0
			if findShipToAttachTo(): return
			inSpaceMovement(delta)
			findPlanetToAttachInSpace()

	scrollBackgrounds(delta)
	
	## Ignore below for now ##
	$MouseOver.global_position = get_global_mouse_position()
	runItemProcess()
	if Input.is_action_pressed("mouse_left"):
		useItem()
	else:
		lastTileItemUsedOn = Vector2(-10,-10)
	
	if Input.is_action_just_pressed("mouse_right"):
		onRightClick()
	
	
	if GlobalRef.chatIsOpen:
		return
	
	#map toggle
	if Input.is_action_just_pressed("map"):
		GlobalRef.camera.mapbg.visible = !GlobalRef.camera.mapbg.visible
		GlobalRef.camera.map.visible = GlobalRef.camera.mapbg.visible
	
	if Input.is_action_just_pressed("noclip"):
		noClip = !noClip
		$CollisionShape2D.disabled = noClip
	
	#var glob = global_position - get_global_mouse_position()
	#var gay = glob.rotated(-GlobalRef.camera.rotation)
	#GlobalRef.playerSide = int(gay.x > 0)
	
	
######################################################################
############################## MOVEMENT ##############################
######################################################################

func determineMovementState(delta):
	match movementState:
		0:
			if state == 0:
				onPlanetMovement(delta)
			else:
				onShipMovement(delta)
		1:
			chairMovement(delta)
		2:
			ladderMovement(delta)

func noClipMovement(delta):
	var dir = Vector2.ZERO
	dir.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	dir.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	
	if GlobalRef.chatIsOpen:
		dir = Vector2.ZERO
	
	if Input.is_action_just_pressed("scroll_up"):
		noClipSpeed += 100
	elif Input.is_action_just_pressed("scroll_down"):
		noClipSpeed -= 100
		noClipSpeed = max(0,noClipSpeed)
		
	
	velocity = dir.normalized() * noClipSpeed
	move_and_slide()
	
	
	GlobalRef.camera.rotation = 0
	ensureCamPosition()
	updateLight()


func onPlanetMovement(delta):
	
	if noClip:
		noClipMovement(delta)
		return
	
	var newRotation = getPlanetPosition()
	
	if newRotation != rotated:
		rotationDelayTicks -= 1
		if rotationDelayTicks <= 0:
			rotated = newRotation
			rotationDelayTicks = 8
	else:
		rotationDelayTicks = 8 #frame delay
	
	sprite.rotation = lerp_angle(sprite.rotation,rotated*(PI/2),0.4)
	$itemWorldRotation.rotation = sprite.rotation
	up_direction = Vector2(0,-1).rotated(rotated*(PI/2))
	
	var underCeiling = isUnderCeiling(rotated*(PI/2))
	var onFloor = isOnFloor(rotated*(PI/2))
	var speed = PlayerData.speed
	
	if underCeiling:
		speed = 25.0
		squishSprites(0.68,delta)
	else:
		squishSprites(1.0,delta)
	
	var dir = 0
	if Input.is_action_pressed("move_left"):
		GlobalRef.playerSide = 0
		dir -= 1
	if Input.is_action_pressed("move_right"):
		GlobalRef.playerSide = 1
		dir += 1
		
	if GlobalRef.chatIsOpen:
		dir = 0
	
	var newVel = velocity.rotated(-rotated*(PI/2))
	if beingKnockedback:
		newVel.x = lerp(newVel.x, dir * speed, 0.025)
	else:
		newVel.x = lerp(newVel.x, dir * speed, 1.0-pow(2.0,(-delta/0.04)))
	newVel.y += gravity * delta
	newVel.y = min(newVel.y,300)
	var tile = planetOn.posToTile(position)
	
	if tile != null:
		# if in water
		if abs(planetOn.DATAC.getWaterData(tile.x,tile.y)) > 0.2:
			wasInWater = true
			newVel.y = min(newVel.y,50)
			if Input.is_action_pressed("jump") and !GlobalRef.chatIsOpen:
				newVel.y = -100.0
			if onFloor:
				GlobalRef.camera.rotation = lerp_angle(GlobalRef.camera.rotation,rotated*(PI/2),1.0-pow(2.0,(-delta/0.06)))
		else:
			if wasInWater and Input.is_action_pressed("jump"):
				newVel.y += -150.0
				wasInWater = false
			
			if onFloor:
				if Input.is_action_just_pressed("jump") and !GlobalRef.chatIsOpen:
					newVel.y = -275
				GlobalRef.camera.rotation = lerp_angle(GlobalRef.camera.rotation,rotated*(PI/2),1.0-pow(2.0,(-delta/0.06)))

	
	velocity = newVel.rotated(rotated*(PI/2))
	
	move_and_slide()
	
	playerAnimation(dir,newVel,delta)
	updateLight()
	
	ensureCamPosition()
	
	
	if is_on_floor() and beingKnockedback:
		beingKnockedback = false

func onShipMovement(delta):
	
	if noClip:
		noClipMovement(delta)
		return
	
	var newRotation = shipOn.rotation
	
	sprite.rotation = lerp_angle(sprite.rotation,shipOn.rotation,0.4)
	$itemWorldRotation.rotation = sprite.rotation
	up_direction = Vector2(0,-1).rotated(shipOn.rotation)
	
	var underCeiling = isUnderCeiling(shipOn.rotation)
	var onFloor = isOnFloor(shipOn.rotation)
	var speed = PlayerData.speed
	
	if planetOn != null:
		rotationDelayTicks = -10
		rotated = getPlanetPosition()
	
	if underCeiling:
		speed = 25.0
		squishSprites(0.68,delta)
	else:
		squishSprites(1.0,delta)
	
	var dir = 0
	if Input.is_action_pressed("move_left"):
		GlobalRef.playerSide = 0
		dir -= 1
	if Input.is_action_pressed("move_right"):
		GlobalRef.playerSide = 1
		dir += 1
	
	if GlobalRef.chatIsOpen:
		dir = 0
	
	var newVel = velocity.rotated(-shipOn.rotation)
	newVel.x = lerp(newVel.x, dir * speed, 1.0-pow(2.0,(-delta/0.04)))
	newVel.y += gravity * delta
	newVel.y = min(newVel.y,300)
	
	if onFloor:
		if Input.is_action_just_pressed("jump") and !GlobalRef.chatIsOpen:
			newVel.y = -275
		if int(Input.is_action_pressed("rotateShipRight")) - int(Input.is_action_pressed("rotateShipLeft")) == 0:
			GlobalRef.camera.rotation = lerp_angle(GlobalRef.camera.rotation,shipOn.rotation,1.0-pow(2.0,(-delta/0.2)))

	velocity = newVel.rotated(shipOn.rotation)
	
	move_and_slide()
	
	playerAnimation(dir,newVel,delta)
	updateLight()
	
	ensureCamPosition()

func chairMovement(delta):
	
	velocity = Vector2.ZERO
	
	
	if shipOn != null:
		sprite.rotation = shipOn.rotation
		GlobalRef.camera.rotation = lerp_angle(GlobalRef.camera.rotation,shipOn.rotation,1.0-pow(2.0,(-delta/0.2)))
	
	if Input.is_action_pressed("jump"):
		movementState = 0
	
	squishSprites(1.0,delta)
	eyeBallAnim()
	updateLight()
	ensureCamPosition()

func ladderMovement(delta):
	var vdir = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	
	var hdir = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	if hdir != 0:
		flipPlayer(hdir)
	
	## animtation
	if vdir != 0:
		ladderTick += 1
		if ladderTick % 7 == 0:
			if getPlayerFrame() == 8:
				setAllPlayerFrames(9)
			else:
				setAllPlayerFrames(8)
	else:
		ladderTick = 6
	
	var obj = planetOn
	
	var newVel = Vector2.ZERO
	var ladderSpeed = 80
	
	if is_instance_valid(shipOn):
		obj = shipOn
		newVel = velocity.rotated(-shipOn.rotation)
		newVel = Vector2(0,vdir * ladderSpeed)
	else:
		newVel = velocity.rotated(-rotated*(PI/2))
		newVel = Vector2(0,vdir * ladderSpeed)
	
	
	if Input.is_action_pressed("jump"):
		movementState = 0
		newVel.y = -250 
		
	
	
	var tile = obj.posToTile(obj.to_local(global_position))
	
	if tile == null: # return early if player walks ladder to sky limit
		movementState = 0
		newVel.y = -250 * int(Input.is_action_pressed("move_up"))
		velocity = newVel.rotated(rotated*(PI/2))
		move_and_slide()
		return
	
	var blockType = obj.DATAC.getTileData(tile.x,tile.y)
	if blockType != 25:
		movementState = 0
		newVel.y = -250 * int(Input.is_action_pressed("move_up"))
	
	if is_instance_valid(shipOn):
		velocity = newVel.rotated(shipOn.rotation)
	else:
		velocity = newVel.rotated(rotated*(PI/2))
	
	move_and_slide()
	
	squishSprites(1.0,delta)
	eyeBallAnim()
	updateLight()
	ensureCamPosition()
	
func inSpaceMovement(delta):
	
	if noClip:
		noClipMovement(delta)
		return
	
	var dir = Vector2.ZERO
	dir.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	dir.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	
	velocity += dir.normalized() * 2
	
	sprite.rotate(1.0 * delta)
	
	GlobalRef.camera.rotation = lerp_angle(GlobalRef.camera.rotation,0,1.0-pow(2.0,(-delta/0.2)))
	
	move_and_slide()
	ensureCamPosition()


func searchForBorders():
	
	var systemWidth = 99900
	
	if position.x < -(systemWidth/2):
		position.x += systemWidth
		GlobalRef.system.generateSystem()
	if position.y < -(systemWidth/2):
		position.y += systemWidth
		GlobalRef.system.generateSystem()
	if position.x > (systemWidth/2):
		position.x -= systemWidth
		GlobalRef.system.generateSystem()
	if position.y > (systemWidth/2):
		position.y -= systemWidth
		GlobalRef.system.generateSystem()
	
func detachFromShip():
	if state == 1 or state == 2:
		#Code for dismounting ship
		var pos = shipOn.posToTile(shipOn.to_local(global_position))
		if pos == null:
			#reparent(shipOn.get_parent())
			velocity += shipOn.velocity
			move_and_slide()
			ensureCamPosition()
			shipOn = null
			if planetOn == null:
				state = 3
			else:
				state = 0
			return true
		if shipOn.DATAC.getBGData(pos.x,pos.y) < 2: #If background is air
			#reparent(shipOn.get_parent())
			velocity += shipOn.velocity
			move_and_slide()
			ensureCamPosition()
			shipOn = null
			if planetOn == null:
				state = 3
			else:
				state = 0
			return true
	return false

func findShipToAttachTo():
	var areas = $ShipCollider.get_overlapping_areas()
	if areas.size() <= 0:
		return false
	
	var ship = areas[0].get_parent()
	var pos = ship.posToTile(ship.to_local(global_position))
	if pos == null:
		return false
	if ship.DATAC.getBGData(pos.x,pos.y) > 1: #If background is solid
		shipOn = ship
		velocity -= shipOn.velocity
		move_and_slide()
		if planetOn == null:
			state = 1
		else:
			state = 2
		return true
	
	return false

## IF PLAYER IS OUTSIDE SHIP
func findPlanetToAttachInSpace():
	if planetOn != null:
		return
	for planet in system.cosmicBodyContainer.get_children():
		var distance = planet.global_position - global_position
		var minimumDis = sqrt(pow(planet.SIZEINCHUNKS*32,2) * 2) + 570
		if distance.length() <= minimumDis:
			attachToPlanet(planet)
			state = 0
			return

func detachFromPlanetToSpace():
	if planetOn == null:
		return
	var maxDis = sqrt(pow(planetOn.SIZEINCHUNKS*32,2) * 2) + 620
	var distance = planetOn.global_position - global_position
	if distance.length() > maxDis:
		detachFromPlanet()
		state = 3

## IF PLAYER IS INSIDE SHIP
func findPlanetToAttachInShip():
	if planetOn != null:
		return
	for planet in system.cosmicBodyContainer.get_children():
		var distance = planet.global_position - global_position
		var minimumDis = sqrt(pow(planet.SIZEINCHUNKS*32,2) * 2) + 570
		if distance.length() <= minimumDis:
			planet.loadPlanet()
			planetOn = planet
			#shipOn.
			reparent(planet.entityContainer)
			shipOn.reparent(planet.entityContainer)
			state = 2
			return

func shipDetachFromPlanet():
	if planetOn == null:
		return
	var maxDis = sqrt(pow(planetOn.SIZEINCHUNKS*32,2) * 2) + 620
	var distance = planetOn.global_position - global_position
	if distance.length() > maxDis:
		var s = planetOn
		planetOn = null
		s.unloadPlanet()
		var relativePosition = shipOn.to_local(global_position)
		reparent(system.objectContainer)
		shipOn.reparent(system.objectContainer)
		
		global_position = shipOn.global_position + relativePosition.rotated(shipOn.rotation)
		
		state = 1

func attachToPlanet(planet:Planet):
	planet.loadPlanet()
	planetOn = planet
	reparent(planetOn.entityContainer)

func detachFromPlanet():
	var s = planetOn
	planetOn = null
	s.unloadPlanet()
	reparent(system.objectContainer)



func ensureCamPosition():
	#camera.global_position = cameraOrigin.global_position
	cameraOrigin.position = Vector2(0,-40).rotated(GlobalRef.camera.rotation)
	#if shipOn != null:
	#	cameraOrigin.position += shipOn.velocity
	cameraOrigin.position.x = int(cameraOrigin.position.x)
	cameraOrigin.position.y = int(cameraOrigin.position.y)
	GlobalRef.camera.global_position = to_global(cameraOrigin.position)
	
	if shipOn:
		GlobalRef.camera.cpass(shipOn.velocity)
	else:
		GlobalRef.camera.cpass(velocity)

######################################################################
############################## ITEMS #################################
######################################################################

func useItem():
	
	var itemData = PlayerData.getSelectedItemData()
	if itemData == null:
		$PlayerLayers/handFront.visible = true
		return
	

	
	# Determine whether or not to target ship
	var areas = $MouseOver.get_overlapping_areas()
	var ship = null
	var editBody = planetOn
	if areas.size() > 0:
		ship = areas[0].get_parent()
		var mousePos = ship.get_local_mouse_position()
		var tile = ship.posToTile(mousePos)
		if tile != null:
			if ship.DATAC.getBGData(tile.x,tile.y) > 1:
				editBody = ship
			elif ship.DATAC.getTileData(tile.x,tile.y) > 1:
				editBody = ship
			else:
				for x in range(3):
					for y in range(3):
						if ship.DATAC.getTileData(tile.x+x-1,tile.y+y-1) > 1:
							editBody = ship
							break
						if ship.DATAC.getBGData(tile.x+x-1,tile.y+y-1) > 1:
							editBody = ship
							break
	
	if editBody == null:
		return
	
	var mousePos = editBody.get_local_mouse_position()
	var tile = editBody.posToTile(mousePos)
	
	if itemData != null and tile != null:
		
		if itemData.clickToUse:
			if Input.is_action_just_pressed("mouse_left"):
				itemData.onUse(tile.x,tile.y,getPlanetPosition(),editBody,lastTileItemUsedOn)
		else:
			itemData.onUse(tile.x,tile.y,getPlanetPosition(),editBody,lastTileItemUsedOn)
		
		lastTileItemUsedOn = Vector2(tile.x,tile.y)

func swapSlot():
	# clear previousAnimation
	for i in itemRoot.get_children():
		i.queue_free()
	
	var itemID = PlayerData.getSelectedItemID()
	var s = ItemData.matchItemAnimation(itemID)
	
	if s == null:
		heldItemAnim = null
		return
	
	var ins = ItemData.heldItemAnims[s].instantiate()
	ins.itemID = itemID
	ins.handColor = $PlayerLayers/body.modulate
	
	heldItemAnim = ins
	itemRoot.add_child(ins)

func runItemProcess():
	if !is_instance_valid(heldItemAnim):
		return
	
	$PlayerLayers/handFront.visible = !heldItemAnim.visible
	
	if Input.is_action_just_pressed("mouse_left"):
		heldItemAnim.onFirstUse()
	
	if Input.is_action_pressed("mouse_left"):
		heldItemAnim.onUsing()
	else:
		heldItemAnim.onNotUsing()

func onRightClick():
	
	#cancel if out of range
	if get_local_mouse_position().length() > 48:
		return
	
	# Determine whether or not to target ship
	var areas = $MouseOver.get_overlapping_areas()
	var ship = null
	var editBody = planetOn
	if areas.size() > 0:
		ship = areas[0].get_parent()
		var mousePos = ship.get_local_mouse_position()
		var tile = ship.posToTile(mousePos)
		if tile != null:
			if ship.DATAC.getBGData(tile.x,tile.y) > 1:
				editBody = ship
			elif ship.DATAC.getTileData(tile.x,tile.y) > 1:
				editBody = ship
			else:
				for x in range(3):
					for y in range(3):
						if ship.DATAC.getTileData(tile.x+x-1,tile.y+y-1) > 1:
							editBody = ship
							break
						if ship.DATAC.getBGData(tile.x+x-1,tile.y+y-1) > 1:
							editBody = ship
							break
	
	if editBody == null:
		return
	
	var mousePos = editBody.get_local_mouse_position()
	var tile = editBody.posToTile(mousePos)
	var blockType = editBody.DATAC.getTileData(tile.x,tile.y)
	
	# right click functionality for each block
	match blockType:
		19: # chair
			movementState = 1 # enter chair state
			chairSit(tile,editBody)
		22: # closed door
			openDoor(tile,editBody,GlobalRef.playerSide)
		23: # open door
			closeDoor(tile,editBody)
		25: # ladder
			if movementState == 2:
				return
			movementState = 2 # enter ladder state
			attachToLadder(tile,editBody)

func openDoor(tile,body,playerDir):
	var info = body.DATAC.getInfoData(tile.x,tile.y) % 2 # top or bottom of door
	var doorType = body.DATAC.getInfoData(tile.x,tile.y) / 2
	
	var swing = playerDir * 4
	var startInfo = info * 2
	if playerDir == 0:
		startInfo = 1 + (info * 2)
		
	if BlockData.checkIfPlaceable(tile.x,tile.y,body,Vector2i(2,2),false,startInfo,22):
		var d = BlockData.placeTiles(tile.x,tile.y,body,Vector2i(2,2),23,startInfo,(doorType * 8) + swing)
		body.editTiles(d)
	else: # if open fails, try opening in other direction
		playerDir = 1 - playerDir
		swing = playerDir * 4
		startInfo = info * 2
		if playerDir == 0:
			startInfo = 1 + (info * 2)
		
		if BlockData.checkIfPlaceable(tile.x,tile.y,body,Vector2i(2,2),false,startInfo,22):
			var d = BlockData.placeTiles(tile.x,tile.y,body,Vector2i(2,2),23,startInfo,(doorType * 8) + swing)
			body.editTiles(d)

func closeDoor(tile,body):
	var info = body.DATAC.getInfoData(tile.x,tile.y)
	var doorSwing = 0
	var dick = {}
	
	if info % 8 < 4:
		doorSwing = 1
	
	var d = BlockData.placeDoor(tile.x,tile.y,body,info % 4,(info/8)*2,doorSwing)
	body.editTiles(d)
	

func chairSit(tile,editBody):
	$AnimationPlayer.play("sit")
	setAllPlayerFrames(7)
	snapToPosition(tile,editBody)
	wasInWater = false

func attachToLadder(tile,editBody):
	$AnimationPlayer.play("climbLadder")
	setAllPlayerFrames(9)
	snapToPosition(tile,editBody)
	wasInWater = false

func snapToPosition(tile,editBody):
	var info = editBody.DATAC.getInfoData(tile.x,tile.y)
	
	var pos = editBody.tileToPos(tile)
	if editBody is Ship:
		pos = editBody.tileToPosRotated(tile)
	
	var dif = -2
	if info % 2 == 0:
		dif = 6
	var offset = Vector2(0,dif).rotated((PI/2)*getPlanetPosition())
			
	if state == 1:
		offset = offset.rotated(editBody.rotation)
			
	position = pos + offset
			
	if editBody is Ship:
		position += editBody.position
	
	if info % 4 <= 1:
		flipPlayer(1)
	else:
		flipPlayer(-1)
	
	if state == 3:
		await get_tree().process_frame
		position = pos + offset
		if editBody is Ship:
			position += editBody.position


func scanForStations():
	var scanBody = planetOn
	if is_instance_valid(shipOn):
		scanBody = shipOn
	
	if !is_instance_valid(scanBody):
		return []
		
	var scan :Array[int]= []
	for x in range(12):
		for y in range(12):
			var pos = Vector2(x,y) + scanBody.posToTile(scanBody.to_local(global_position)) - Vector2(6,6)
			
			var tile = scanBody.DATAC.getTileData(pos.x,pos.y)
			if !scan.has(tile):
				scan.append(tile)
	
	return scan

######################################################################
############################ ANIMATION ###############################
######################################################################

func flipPlayer(dir):
	sprite.scale.x = dir
	$itemWorldRotation.scale.x = dir

func playerAnimation(dir,newVel,delta):
	#improve this later
	if dir != 0:
		flipPlayer(dir)
	
	var glob = global_position - get_global_mouse_position()
	var gay = glob.rotated(-GlobalRef.camera.rotation)
	var newDir = (int(gay.x < 0) * 2) - 1
	
	# rotate player if using item
	if Input.is_action_pressed("mouse_left"):
		flipPlayer(newDir)
	
	eyeBallAnim()
	
	var flor = isOnFloor(rotated*(PI/2))
	if shipOn != null:
		flor = isOnFloor(shipOn.rotation)
	
	if !flor:
		if newVel.y <= 0:
			animationPlayer.play("jump")
			return
		else:
			animationPlayer.play("fall")
			return
	if dir == 0:
		animationPlayer.play("idle")
	elif animationPlayer.current_animation != "walk":
			animationPlayer.play("walk")

func eyeBallAnim():
	var glob = global_position - get_global_mouse_position()
	var gay = glob.rotated(-GlobalRef.camera.rotation)
	$PlayerLayers/eye/Pupil.offset = gay.normalized() * Vector2(-sprite.scale.x,-1)
	
	# silly blink
	blinkTick += 1
	if blinkTick > 120:
		if randi() % 60 == 0:
			$PlayerLayers/eye.visible = false
			blinkTick = -5
			if randi() % 6 == 0:
				blinkTick = -15
			
	if blinkTick == 0 or blinkTick == -10:
		$PlayerLayers/eye.visible = true
	elif blinkTick == -5:
		$PlayerLayers/eye.visible = false

func setAllPlayerFrames(frame:int):
	for obj in sprite.get_children():
		obj.frame = frame
		
func getPlayerFrame():
	return sprite.get_children()[0].frame


func squishSprites(target,delta):
	for obj in sprite.get_children():
		obj.scale.y = lerp(obj.scale.y,target,1.0-pow(2.0,(-delta/0.02)))
		if obj == $PlayerLayers/eye:
			obj.scale.y = 1.0
			obj.position.y = lerp(obj.position.y,3.0+(3.0*int(target!=1.0)), 1.0-pow( 2.0,( -delta/0.02 ) ) )

func scrollBackgrounds(delta):
	Background.scroll(velocity.rotated(-GlobalRef.camera.rotation)*-delta)
	
	
func scrollBackgroundsSpace(vel,delta):
	Background.scroll(vel.rotated(-GlobalRef.camera.rotation)*-delta)
	pass


func changeArmor():
	
	var helmet = PlayerData.getSlotItemData(40)
	var chest = PlayerData.getSlotItemData(41)
	var legs = PlayerData.getSlotItemData(42)
	
	var vanityHelmet = PlayerData.getSlotItemData(50)
	var vanityChest = PlayerData.getSlotItemData(51)
	var vanityLegs = PlayerData.getSlotItemData(52)
	
	var newDefense = 0
	
	
	# check for main armor
	if helmet is ItemArmorHelmet:
		helmetSpr.texture =  helmet.armorTexture
		newDefense += helmet.defense
	else:
		helmetSpr.texture = null
	if chest is ItemArmorChest:
		chestSpr.texture =  chest.armorTexture
		newDefense += chest.defense
	else:
		chestSpr.texture = null
	if legs is ItemArmorLegs:
		legsSpr.texture =  legs.armorTexture
		newDefense += legs.defense
	else:
		legsSpr.texture = null
	
	# check for vanity
	if vanityHelmet is ItemArmorHelmet:
		helmetSpr.texture =  vanityHelmet.armorTexture

	if vanityChest is ItemArmorChest:
		chestSpr.texture =  vanityChest.armorTexture

	if vanityLegs is ItemArmorLegs:
		legsSpr.texture =  vanityLegs.armorTexture

	
	$HealthComponent.defense = newDefense
	GlobalRef.hotbar.updateDefense(newDefense)

######################################################################
############################### MATHS ################################
######################################################################

func getPlanetPosition():
	if !is_instance_valid(planetOn):
		return 0
	var p = planetOn.posToTile(position)
	if p == null:
		var angle1 = Vector2(1,1)
		var angle2 = Vector2(-1,1)
		
		var dot1 = int(position.dot(angle1) >= 0)
		var dot2 = int(position.dot(angle2) > 0) * 2
		
		return [0,1,3,2][dot1 + dot2]
	return planetOn.DATAC.getPositionLookup(p.x,p.y)

func isOnFloor(rot):
	#improve this
	$FloorAngles.rotation = rot
	
	$FloorAngles/FloorCast1.force_raycast_update()
	$FloorAngles/FloorCast2.force_raycast_update()
	
	if $FloorAngles/FloorCast1.is_colliding():
		return true
	if $FloorAngles/FloorCast2.is_colliding():
		return true
	return false

func isUnderCeiling(rot):
	#improve this
	$CeilingAngles.rotation = rot
	
	$CeilingAngles/cCast1.force_raycast_update()
	$CeilingAngles/cCast2.force_raycast_update()
	
	if $CeilingAngles/cCast1.is_colliding():
		return true
	if $CeilingAngles/cCast2.is_colliding():
		return true
	return false

func enteredNewChunk(newChunk):
	var planetRadius = planetOn.SIZEINCHUNKS * 32
	var newPos = (newChunk * 64) - Vector2(planetRadius,planetRadius) - Vector2(288,288)
	GlobalRef.lightmap.pushUpdate(planetOn,newPos)
	planetOn.loadChunkArea(newChunk)

######################################################################
############################# LIGHTS #################################
##################### DO NOT TOUCH !!!!!!!!!!!!#######################
######################################################################

func updateLight():
	if !is_instance_valid(planetOn):
		return
	
	var pos = position
	var planetRadius = planetOn.SIZEINCHUNKS * 32
	
	var currentChunk = Vector2(int(pos.x+planetRadius)/64,int(pos.y+planetRadius)/64)
	if previousChunk != currentChunk:
		enteredNewChunk(currentChunk)
	previousChunk = currentChunk

func updateLightStatic():
	if !is_instance_valid(planetOn):
		return
	
	var pos = position
	#if state == 2:
	#	pos += shipOn.position
	
	
	var currentChunk = Vector2(int(pos.x+1024)/64,int(pos.y+1024)/64)
	var newPos = (currentChunk * 64) - Vector2(1024,1024) - Vector2(288,288)
	GlobalRef.lightmap.pushUpdate(planetOn,newPos)


func _on_health_component_health_changed():
	PlayerData.sendHealthUpdate($HealthComponent.health,$HealthComponent.maxHealth)


func spawnShip():
	var ins = shipDEBUG.instantiate()
	get_parent().add_child(ins)
	ins.global_position = get_global_mouse_position()
