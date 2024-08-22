extends Node2D

@onready var holdSlot = $holdingSlot

@onready var crafting = $Menu/Crafting

var invOpen = false

var deathTimer :SceneTreeTimer = null

# chat nodes
@onready var cheatOrigin = $Cheat
@onready var textBox = $Cheat/TextEdit
@onready var chat = $Chat
var previousMessage = ""

@onready var chatMessageScene = preload("res://ui_scenes/chat/chat_message.tscn")

var longassstring :PackedStringArray

func _ready():
	
	GlobalRef.hotbar = self
	
	#assign self to slots
	for slot in $Hotbar.get_children():
		slot.parent = self
	for slot in $Menu/InventoryBody.get_children():
		slot.parent = self
	for slot in $Menu/ArmorSlots.get_children():
		slot.parent = self
	for slot in $Menu/AccessorySlots.get_children():
		slot.parent = self
	for slot in $Menu/VanitySlots.get_children():
		slot.parent = self
	for slot in $ChestInventory/slots.get_children():
		slot.parent = self
	
	$Menu.visible = false
	
	# connect health bar
	PlayerData.connect("updateHealth",updateHealth)
	PlayerData.connect("forceOpenInventory",forceOpenInventory)
	
func _process(delta):
	var pos = to_local(get_global_mouse_position()) - Vector2(6,6)
	holdSlot.position = Vector2i( pos )
	if Input.is_action_just_pressed("inventory") and !GlobalRef.chatIsOpen:
		invOpen = !invOpen
		$Menu.visible = invOpen
		
		if !invOpen:
			PlayerData.closeChest()
		$ItemPreview.position.x = (197 * int(invOpen)) + (3 * (1-int(invOpen) ))
	
	$ChestInventory.visible = PlayerData.chestOBJ != null
	$Menu/Crafting.visible = PlayerData.chestOBJ == null
	
	# hotbar scrolling
	
	
	
	
	# cheat commands
	if Input.is_action_just_pressed("openCommand"):
		if cheatOrigin.visible:
			interpretCommand(textBox.text)
		
		cheatOrigin.visible = !cheatOrigin.visible
		textBox.text = ""
		
		GlobalRef.chatIsOpen = cheatOrigin.visible
		
		if cheatOrigin.visible:
			textBox.grab_focus()
	
	if cheatOrigin.visible:
		if Input.is_action_just_pressed("ui_up"):
			interpretCommand(previousMessage + " ")
	
	# death message
	if is_instance_valid(deathTimer):
		$"Death Screen/respawn".text = "respawn in " + str( int(deathTimer.time_left) )
	
	
func clickedSlot(slot):
	if !invOpen:
		return
	if PlayerData.inventory[49][0] == -1: # if hand is empty
		PlayerData.swapItem(slot,49) 
		displayItemName("",null)
		return
	elif PlayerData.inventory[slot][0] == -1: # if slot is empty
		PlayerData.swapItem(slot,49)
		var data = ItemData.getItem(PlayerData.inventory[slot][0])
		displayItemName( ItemData.getItemName( PlayerData.inventory[slot][0] ),data )
		return
	elif PlayerData.inventory[slot][0] != PlayerData.inventory[49][0]:
		PlayerData.swapItem(slot,49)
		var data = ItemData.getItem(PlayerData.inventory[slot][0])
		displayItemName( ItemData.getItemName( PlayerData.inventory[slot][0] ),data )
		return
	else:
		var maxStack = ItemData.data[PlayerData.inventory[slot][0]].maxStackSize
		var total = PlayerData.inventory[slot][1] + PlayerData.inventory[49][1]
		if total <= maxStack:
			PlayerData.inventory[slot][1] = total
			PlayerData.inventory[49] = [-1,-1]
		else:
			PlayerData.inventory[slot][1] = maxStack
			PlayerData.inventory[49][1] = total - maxStack 
		PlayerData.emit_signal("updateInventory")

func splitSlot(slot):
	if !invOpen:
		return

	
	#If Hand slot is empty
	if PlayerData.inventory[49][0] == -1:
		var amount = PlayerData.inventory[slot][1]
		var half = PlayerData.inventory[slot][1] / 2
		if amount <= 1:
			return
		
		PlayerData.inventory[slot][1] = half
		PlayerData.inventory[49] = [PlayerData.inventory[slot][0],amount-half]
		PlayerData.emit_signal("updateInventory")
		PlayerData.emit_signal("selectedSlotChanged")
		if slot >= 53:
			PlayerData.saveChestString()
		return
	#If placement slot is empty
	elif PlayerData.inventory[slot][0] == -1:
		PlayerData.inventory[slot] = [PlayerData.inventory[49][0],1]
		PlayerData.inventory[49][1] -= 1
		if PlayerData.inventory[49][1] <= 0:
			PlayerData.inventory[49] = [-1,-1]
		PlayerData.emit_signal("updateInventory")
		PlayerData.emit_signal("selectedSlotChanged")
		if slot >= 53:
			PlayerData.saveChestString()
		return
	#If neither are empty but they aren't the same item type
	elif PlayerData.inventory[slot][0] != PlayerData.inventory[49][0]:
		return
	#If neither are empty but they ARE the same item type
	else:
		var maxStack = ItemData.data[PlayerData.inventory[slot][0]].maxStackSize
		
		if PlayerData.inventory[slot][1] >= maxStack:
			return
		
		PlayerData.inventory[slot][1] += 1
		
		PlayerData.inventory[49][1] -= 1
		if PlayerData.inventory[49][1] <= 0:
			PlayerData.inventory[49] = [-1,-1]
		PlayerData.emit_signal("updateInventory")
		PlayerData.emit_signal("selectedSlotChanged")
		if slot >= 53:
			PlayerData.saveChestString()
		return
		
func updateHealth():
	$HealthBar/healthText.text = str(PlayerData.currentHealth) + " / " + str(PlayerData.maxHealth)
	$HealthBar/bar.scale.x = PlayerData.currentHealth
	$HealthBar/barShadow.scale.x = PlayerData.maxHealth


func interpretCommand(text):
	
	#remove accidental slash
	text = text.left(-1)
	
	previousMessage = text
	
	var command = text.get_slice(" ",0)
	match command:
		"fullbright":
			GlobalRef.lightmap.visible = !GlobalRef.lightmap.visible
			if GlobalRef.lightmap.visible:
				GlobalRef.sendChat("Fullbright: DISABLED")
			else:
				GlobalRef.sendChat("Fullbright: ENABLED")
		"give":
			var item = text.get_slice(" ",1)
			var amount = text.get_slice(" ",2)
			
			if item == "":
				GlobalRef.sendError("ERROR: missing item input")
				return # return if item not inputted 
			if !ItemData.itemExists(int(item)):
				GlobalRef.sendError("ERROR: item of id " + item + " does not exist.")
				return # return if item does not exist

			if amount == "":
				amount = "1" # make amount 1 if no amount in entered
			
			PlayerData.addItem(int(item),int(amount))
			GlobalRef.sendChat("Gave player " + amount + " " + ItemData.getItemName(int(item)))
		
		"ship":
			GlobalRef.player.spawnShip()
		
		"tick":
			var amount = text.get_slice(" ",1)
			if amount == "":
				GlobalRef.sendError("ERROR: missing time input")
				return # return if time not inputted 
			GlobalRef.globalTick += int(amount)
			GlobalRef.sendChat("Advanced time by " + str(int(amount)/15.0) + " seconds.")
		
		"time":
			GlobalRef.sendChat("Time is " + str(GlobalRef.globalTick) + ".")
		
		"zoom":
			var z = text.get_slice(" ",1)
			if z == "":
				GlobalRef.sendError("ERROR: missing zoom amount")
				return
			GlobalRef.camera.zoom = Vector2(float(z),float(z))
			GlobalRef.camera.changeZoom()
			GlobalRef.sendChat("Zoom set to " + z + ".")
		
		"summon":
			var n = text.get_slice(" ",1)
			if n == "" or n == "summon":
				GlobalRef.sendError("ERROR: missing enemy name")
				return
			
			var times = text.get_slice(" ",2)
			if times == "":
				times = "1"
			
			var b = 0
			for i in range(int(times)):
				CreatureData.summonCommand(GlobalRef.currentPlanet,GlobalRef.player.position,n)
				b += 1
			if b == 0:
				GlobalRef.sendError("ERROR: amount invalid")
		
		"noclip":
			GlobalRef.player.toggleNoClip()
			GlobalRef.sendChat("Toggled noclip")
		"inflict":
			var effect = text.get_slice(" ",1)
			if effect == "" or effect == "inflict":
				GlobalRef.sendError("ERROR: missing effect name")
				return
			var time = text.get_slice(" ",2)
			if time == "" or time == effect:
				time = "10"
			GlobalRef.player.healthComponent.inflictStatus(effect,float(time))
			GlobalRef.sendChat("Inflicted player with " + effect + " for " + time + " seconds.")
		"heal":
			GlobalRef.player.healthComponent.heal(1000)
			GlobalRef.sendChat("Healed player.")
		
		"save":
			longassstring = GlobalRef.currentPlanet.DATAC.getSaveString()
		
		"load":
			GlobalRef.currentPlanet.DATAC.loadFromString(longassstring[0],longassstring[1],longassstring[2],longassstring[3],longassstring[4])
			GlobalRef.currentPlanet.forceChunkDrawUpdate()
		
		_:
			GlobalRef.sendError("Error: command doesn't exist")
			return

func printIntoChat(text:String,color:Color = Color.WHITE):
	var newMessage = chatMessageScene.instantiate()
	newMessage.text = text
	newMessage.color = color
	
	for oldMessage in chat.get_children():
		oldMessage.position.y -= 24
	
	chat.add_child(newMessage)

func displayItemName(text:String,itemData:Item):
	
	$ItemPreview/itemSlotName.text = text
	
	if text == "":
		$ItemPreview/subtext.text = ""
		$ItemPreview/information.text = ""
		$ItemPreview/infoBox.visible = false
		$ItemPreview/namebox.visible = false
		return
	
	$ItemPreview/namebox.visible = true
	$ItemPreview/subtext.text = itemData.subtext
	
	## information data
	var infoText = ""
	var size = 0
	if itemData is ItemDamage:
		infoText += "DAMAGE: " + str(itemData.damage) + "\n"
		size += 18
		infoText += "SWING SPEED: " + str(itemData.animSpeed) + "\n"
		size += 18
		if itemData is ItemMining:
			infoText += "MINE SPEED: " + str(itemData.miningMultiplier) + "\n"
			size += 18
	elif itemData is ItemArmor:
		infoText += "DEFENSE: " + str(itemData.defense) + "\n"
		size += 18
	elif itemData is ItemFood:
		infoText += "HEALS: " + str(itemData.healingAmount) + "\n"
		size += 18
		infoText += "EAT TIME: " + str(itemData.eatTime) + "\n"
		size += 18
	elif itemData is ItemPlant:
		infoText += "Can be planted on \n"+ str(itemData.descCanPlaceOn) + "\n"
		size += 18
		size += 18
	elif itemData is ItemTrinket:
		infoText += "Trinket \n"
		size += 18
		infoText += itemData.description
		size += (itemData.description.count("\n") + 1) * 18
	
	if itemData.materialIn.size() > 0:
		infoText += "material \n"
		size += 18
	
	$ItemPreview/information.text = infoText
	$ItemPreview/infoBox.size.y = size
	$ItemPreview/infoBox.visible = (infoText != "")

func updateDefense(amount:int):
	$Menu/defense/defenseAmount.text = str(amount)

func showDeathScreen(time):
	$"Death Screen".visible = true
	deathTimer = get_tree().create_timer(time)
	await deathTimer.timeout
	$"Death Screen".visible = false

func forceOpenInventory():
	invOpen = true
	$Menu.visible = invOpen
	
	#crafting.createCraftingIcons()
	$ItemPreview.position.x = (197 * int(invOpen)) + (3 * (1-int(invOpen) ))


func _on_crafting_vi_s_toggle_pressed():
	crafting.showUncraftables = !crafting.showUncraftables
	crafting.forceReload()
	$Menu/craftingViSToggle/VisibleEyes.frame = int(crafting.showUncraftables)

func _unhandled_input(event):
	
	# mouse scroll
	if event is InputEventMouseButton:
		if event["pressed"] == false:
			return
		var curSlot = PlayerData.selectedSlot
		if event["button_index"] == 4:
			curSlot -= 1
			if curSlot < 0:
				curSlot = 9
			selectSlot(curSlot)
		elif event["button_index"] == 5:
			curSlot += 1
			if curSlot > 9:
				curSlot = 0
			selectSlot(curSlot)
		
		return
	
	# inventory keys
	if not event is InputEventKey:
		return
	
	if event["keycode"] < 49 or event["keycode"] > 57:
		if event["keycode"] == 48: # special case for 0 key
			selectSlot(9)
		return
	selectSlot(event["keycode"]-49)

func selectSlot(slot):
	PlayerData.selectSlot(slot)
	for i in $Hotbar.get_children():
		i.updateSelected()

func updateStatus():
	for c in $StatusDisplay.get_children():
		c.queue_free()
	var i = 0
	for effect in GlobalRef.player.healthComponent.statusEffects:
		var ins = load("res://object_scenes/specialResource/statusEffects/status_display.tscn").instantiate()
		ins.status = effect
		ins.position.y = i * 10
		$StatusDisplay.add_child(ins)
		i += 1
