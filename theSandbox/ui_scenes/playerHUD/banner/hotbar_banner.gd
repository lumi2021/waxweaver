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
	holdSlot.position = to_local(get_global_mouse_position()) - Vector2(6,6)
	if Input.is_action_just_pressed("inventory") and !GlobalRef.chatIsOpen:
		invOpen = !invOpen
		$Menu.visible = invOpen
		
		if invOpen:
			crafting.createCraftingIcons()
		else:
			PlayerData.closeChest()
		$ItemPreview.position.x = (197 * int(invOpen)) + (3 * (1-int(invOpen) ))
	
	$ChestInventory.visible = PlayerData.chestOBJ != null
	$Menu/Crafting.visible = PlayerData.chestOBJ == null
	
	# hotbar scrolling
	var curSlot = PlayerData.selectedSlot
	if Input.is_action_just_pressed("scroll_up"):
		curSlot -= 1
		if curSlot < 0:
			curSlot = 9
		PlayerData.selectSlot(curSlot)
		for slot in $Hotbar.get_children():
			slot.updateSelected()
	elif Input.is_action_just_pressed("scroll_down"):
		curSlot += 1
		if curSlot > 9:
			curSlot = 0
		PlayerData.selectSlot(curSlot)
		for slot in $Hotbar.get_children():
			slot.updateSelected()
	
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
		if slot >= 53:
			PlayerData.saveChestString()
		return
		
func updateHealth():
	$HealthBar/healthText.text = str(PlayerData.currentHealth) + " / " + str(PlayerData.maxHealth)
	$HealthBar/bar.scale.x = PlayerData.currentHealth / 2.0
	$HealthBar/barShadow.scale.x = PlayerData.maxHealth / 2.0


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
	
	if itemData.materialIn.size() > 0:
		infoText += "material \n"
		size += 18
	
	$ItemPreview/information.text = infoText
	$ItemPreview/infoBox.size.y = size
	$ItemPreview/infoBox.visible = (infoText != "")

func updateDefense(amount:int):
	$Menu/defense/defenseAmount.text = str(amount)

func showDeathScreen():
	$"Death Screen".visible = true
	deathTimer = get_tree().create_timer(5.0)
	await deathTimer.timeout
	$"Death Screen".visible = false

func forceOpenInventory():
	invOpen = true
	$Menu.visible = invOpen
	
	crafting.createCraftingIcons()
	$ItemPreview.position.x = (197 * int(invOpen)) + (3 * (1-int(invOpen) ))


func _on_crafting_vi_s_toggle_pressed():
	crafting.showUncraftables = !crafting.showUncraftables
	crafting.updateUncraftableVis()
	$Menu/craftingViSToggle/VisibleEyes.frame = int(crafting.showUncraftables)
