extends CharacterBody2D
class_name Player


@export var system : Node2D

@onready var sprite = $PlayerLayers
@onready var backItem = $BackItem
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


var animTick = 0

var maxCameraDistance := 0

var lastTileItemUsedOn := Vector2(-10,-10)

var noClip = false

var tick = 0

######################################################################
########################### BASIC FUNTIONS ###########################
######################################################################


func _ready():
	GlobalRef.player = self
	
	PlayerData.updateInventory.connect(setBackItemTexture)
	
	PlayerData.addItem(1,1)
	PlayerData.addItem(0,1)
	PlayerData.addItem(1000,1)
	PlayerData.addItem(7,99)
	PlayerData.addItem(13,198)
	PlayerData.addItem(-13,198)

func _process(delta):
	
	tick+=1
	print(state)
	
	match state:
		0: #On planet
			onPlanetMovement(delta)
			findShipToAttachTo()
			detachFromPlanetToSpace()
		1: #On ship in space
			if detachFromShip(): return
			onShipMovement(delta)
			findPlanetToAttachInShip()
		2: # On ship on planet
			onShipMovement(delta)
			detachFromShip()
			shipDetachFromPlanet()
		3: # In space
			if findShipToAttachTo(): return
			inSpaceMovement(delta)
			findPlanetToAttachInSpace()

	scrollBackgrounds(delta)
	
	## Ignore below for now ##
	$MouseOver.global_position = get_global_mouse_position()
	if Input.is_action_pressed("mouse_left"):
		useItem()
	else:
		lastTileItemUsedOn = Vector2(-10,-10)
		$HandRoot/PlayerHand.visible = false
		$PlayerLayers/handFront.visible = true
	
	#map toggle
	if Input.is_action_just_pressed("map"):
		GlobalRef.camera.mapbg.visible = !GlobalRef.camera.mapbg.visible
		GlobalRef.camera.map.visible = GlobalRef.camera.mapbg.visible
	
	if Input.is_action_just_pressed("spawnDebugShip"):
		var ins = shipDEBUG.instantiate()
		get_parent().add_child(ins)
		ins.global_position = get_global_mouse_position()
	
######################################################################
############################## MOVEMENT ##############################
######################################################################

func onPlanetMovement(delta):
	
	var newRotation = getPlanetPosition()
	
	if newRotation != rotated:
		rotationDelayTicks -= 1
		if rotationDelayTicks <= 0:
			rotated = newRotation
			rotationDelayTicks = 8
	else:
		rotationDelayTicks = 8 #frame delay
	
	sprite.rotation = lerp_angle(sprite.rotation,rotated*(PI/2),0.4)
	$HandRoot.rotation = sprite.rotation
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
		dir -= 1
	if Input.is_action_pressed("move_right"):
		dir += 1
	var newVel = velocity.rotated(-rotated*(PI/2))
	newVel.x = lerp(newVel.x, dir * speed, 1.0-pow(2.0,(-delta/0.04)))
	newVel.y += gravity * delta
	newVel.y = min(newVel.y,300)
	
	if onFloor:
		if Input.is_action_just_pressed("jump"):
			newVel.y = -275
		GlobalRef.camera.rotation = lerp_angle(GlobalRef.camera.rotation,rotated*(PI/2),1.0-pow(2.0,(-delta/0.06)))

	
	velocity = newVel.rotated(rotated*(PI/2))
	
	move_and_slide()
	
	playerAnimation(dir,newVel,delta)
	updateLight()
	
	ensureCamPosition()

func onShipMovement(delta):
	
	var newRotation = shipOn.rotation
	
	sprite.rotation = lerp_angle(sprite.rotation,shipOn.rotation,0.4)
	$HandRoot.rotation = sprite.rotation
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
		dir -= 1
	if Input.is_action_pressed("move_right"):
		dir += 1
	
	var newVel = velocity.rotated(-shipOn.rotation)
	newVel.x = lerp(newVel.x, dir * speed, 1.0-pow(2.0,(-delta/0.04)))
	newVel.y += gravity * delta
	newVel.y = min(newVel.y,300)
	
	if onFloor:
		if Input.is_action_just_pressed("jump"):
			newVel.y = -275
		GlobalRef.camera.rotation = lerp_angle(GlobalRef.camera.rotation,shipOn.rotation,1.0-pow(2.0,(-delta/0.06)))

	velocity = newVel.rotated(shipOn.rotation)
	
	move_and_slide()
	
	playerAnimation(dir,newVel,delta)
	updateLight()
	
	ensureCamPosition()

func inSpaceMovement(delta):
	var dir = Vector2.ZERO
	dir.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	dir.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	
	velocity += dir.normalized() * 2
	
	sprite.rotate(1.0 * delta)
	
	GlobalRef.camera.rotation = 0
	
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
		
		global_position = shipOn.global_position + relativePosition
		
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

######################################################################
############################## ITEMS #################################
######################################################################

func useItem():
	
	var itemData = PlayerData.getSelectedItemData()
	if itemData == null:
		$HandRoot/PlayerHand.visible = false
		$PlayerLayers/handFront.visible = true
		$HandRoot/handSwing.stop()
		return
	
	
	if Input.is_action_just_pressed("anyInventoryKey"):
		$HandRoot/handSwing.stop()
		$HandRoot/PlayerHand/itemSprite.texture = itemData.texture
		return
	
	var areas = $MouseOver.get_overlapping_areas()
	var ship = null
	var editBody = planetOn
	if areas.size() > 0:
		ship = areas[0].get_parent()
		var mousePos = ship.get_local_mouse_position()
		var tile = ship.posToTile(mousePos)
		print(tile)
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
	
	
	#if !is_instance_valid(planet) and !is_instance_valid(ship):
	#	return
	
	if editBody == null:
		return
	
	var mousePos = editBody.get_local_mouse_position()
	var tile = editBody.posToTile(mousePos)
	
	if itemData != null and tile != null:
		
		if itemData.clickToUse:
			if Input.is_action_just_pressed("mouse_left"):
				itemData.onUse(tile.x,tile.y,getPlanetPosition(),editBody,lastTileItemUsedOn)
				itemSwingAnimation(itemData)
				
				
		else:
			itemData.onUse(tile.x,tile.y,getPlanetPosition(),editBody,lastTileItemUsedOn)
			if !$HandRoot/handSwing.is_playing():
				itemSwingAnimation(itemData)
			
		lastTileItemUsedOn = Vector2(tile.x,tile.y)

func itemSwingAnimation(itemData):
	$HandRoot/handSwing.play("swing")
	$HandRoot/PlayerHand/itemSprite.texture = itemData.texture
	$HandRoot/PlayerHand.visible = true
	$PlayerLayers/handFront.visible = false

func _on_hand_swing_animation_finished(anim_name):
	var itemData = PlayerData.getSelectedItemData()
	
	if itemData == null:
		$HandRoot/PlayerHand.visible = false
		$PlayerLayers/handFront.visible = true
		return
	
	if !itemData.clickToUse and Input.is_action_pressed("mouse_left"):
		$HandRoot/handSwing.play(anim_name)
		return
	
	$HandRoot/PlayerHand.visible = false
	$PlayerLayers/handFront.visible = true

######################################################################
############################ ANIMATION ###############################
######################################################################

func playerAnimation(dir,newVel,delta):
	#improve this later
	if dir != 0:
		sprite.scale.x = dir
		backItem.flip_h = dir == 1
		backItem.offset.x = 5.33333 * -dir
		$HandRoot.scale.x = dir
	
	backItem.visible = PlayerData.selectedSlot != 0
	
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

func setBackItemTexture():
	backItem.texture = ItemData.data[PlayerData.inventory[0][0]].texture

func setAllPlayerFrames(frame:int):
	for obj in sprite.get_children():
		obj.frame = frame

func squishSprites(target,delta):
	for obj in sprite.get_children():
		obj.scale.y = lerp(obj.scale.y,target,1.0-pow(2.0,(-delta/0.02)))
		if obj == $PlayerLayers/eye:
			obj.scale.y = 1.0
			obj.position.y = lerp(obj.position.y,3.0+(3.0*int(target!=1.0)), 1.0-pow( 2.0,( -delta/0.02 ) ) )

func scrollBackgrounds(delta):
	for layer in GlobalRef.camera.backgroundHolder.get_children():
		layer.updatePosition(velocity.rotated(-GlobalRef.camera.rotation)*-delta)

func scrollBackgroundsSpace(vel,delta):
	for layer in GlobalRef.camera.backgroundHolder.get_children():
		layer.updatePosition(vel.rotated(-GlobalRef.camera.rotation)*-delta)

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

######################################################################
############################# LIGHTS #################################
##################### DO NOT TOUCH !!!!!!!!!!!!#######################
######################################################################

func updateLight():
	if !is_instance_valid(planetOn):
		return
	
	var pos = position
	#if state == 2:
	#	pos += shipOn.position
	
	var currentChunk = Vector2(int(pos.x+1024)/64,int(pos.y+1024)/64)
	if previousChunk != currentChunk:
		var newPos = (currentChunk * 64) - Vector2(1024,1024) - Vector2(288,288)
		GlobalRef.lightmap.pushUpdate(planetOn,newPos)
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
	previousChunk = currentChunk
