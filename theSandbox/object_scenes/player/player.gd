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


var animTick = 0

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

######################################################################
########################### BASIC FUNTIONS ###########################
######################################################################


func _ready():
	GlobalRef.player = self
	PlayerData.connect("selectedSlotChanged",swapSlot)
	
	PlayerData.addItem(1001,1)
	PlayerData.addItem(1,1)
	PlayerData.addItem(0,1)
	PlayerData.addItem(1000,1)
	PlayerData.addItem(7,99)
	PlayerData.addItem(13,198)
	PlayerData.addItem(-13,99)
	PlayerData.addItem(15,99)
	PlayerData.addItem(16,99)
	
	PlayerData.selectSlot(0)
	

func _process(delta):
	
	tick+=1
	
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
	runItemProcess()
	if Input.is_action_pressed("mouse_left"):
		useItem()
	else:
		lastTileItemUsedOn = Vector2(-10,-10)

	
	#map toggle
	if Input.is_action_just_pressed("map"):
		GlobalRef.camera.mapbg.visible = !GlobalRef.camera.mapbg.visible
		GlobalRef.camera.map.visible = GlobalRef.camera.mapbg.visible
	
	if Input.is_action_just_pressed("spawnDebugShip"):
		var ins = shipDEBUG.instantiate()
		get_parent().add_child(ins)
		ins.global_position = get_global_mouse_position()
	
	if Input.is_action_just_pressed("noclip"):
		noClip = !noClip
		$CollisionShape2D.disabled = noClip
	
######################################################################
############################## MOVEMENT ##############################
######################################################################

func noClipMovement(delta):
	var dir = Vector2.ZERO
	dir.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	dir.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	
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
		dir -= 1
	if Input.is_action_pressed("move_right"):
		dir += 1
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
			if Input.is_action_pressed("jump"):
				newVel.y = -100.0
			if onFloor:
				GlobalRef.camera.rotation = lerp_angle(GlobalRef.camera.rotation,rotated*(PI/2),1.0-pow(2.0,(-delta/0.06)))
		else:
			if wasInWater:
				newVel.y += -150.0
				wasInWater = false
			
			if onFloor:
				if Input.is_action_just_pressed("jump"):
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
		if int(Input.is_action_pressed("rotateShipRight")) - int(Input.is_action_pressed("rotateShipLeft")) == 0:
			GlobalRef.camera.rotation = lerp_angle(GlobalRef.camera.rotation,shipOn.rotation,1.0-pow(2.0,(-delta/0.2)))

	velocity = newVel.rotated(shipOn.rotation)
	
	move_and_slide()
	
	playerAnimation(dir,newVel,delta)
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

######################################################################
############################ ANIMATION ###############################
######################################################################

func playerAnimation(dir,newVel,delta):
	#improve this later
	if dir != 0:
		sprite.scale.x = dir
		$itemWorldRotation.scale.x = dir
	
	var glob = global_position - get_global_mouse_position()
	var gay = glob.rotated(-GlobalRef.camera.rotation)
	var newDir = (int(gay.x < 0) * 2) - 1
	
	# rotate player if using item
	if Input.is_action_pressed("mouse_left"):
		sprite.scale.x = newDir
		$itemWorldRotation.scale.x = newDir
	
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
