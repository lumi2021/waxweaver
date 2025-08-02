extends ColorRect

var itemID :int = 2

var amountAvailable :int = 10
var price :int = 1

var mouseInside :bool = false

var onSale :bool = false

var slotID :int = 0
var forceStock : bool = false

func _ready():
	
	
	if onSale:
		$Sale.show()
		price = max(1,int(price * 0.75))
	
	setInfo()
	PlayerData.connect("updateMoney",updatePriceLabel)
	
	if forceStock:
		amountAvailable = 0
		$soldOutSprite.show()
		$price.hide()
		$itemSprite.modulate = Color.BLACK

func setInfo():
	$itemSprite.texture = ItemData.getItemTexture(itemID)
	$price.text = "$" + str(price)
	$soldOutSprite.hide()
	updatePriceLabel()

func _process(delta):
	if mouseInside:
		$bg.scale = lerp($bg.scale,Vector2(0.8,0.8),0.2)
	else:
		$bg.scale = lerp($bg.scale,Vector2(1.0,1.0),0.2)


func _on_mouse_entered():
	var n = ItemData.getItemName(itemID)
	GlobalRef.hotbar.displayItemName(n,ItemData.getItem(itemID))
	mouseInside = true

func _on_mouse_exited():
	GlobalRef.hotbar.displayItemName("",null)
	mouseInside = false

func _on_purchase_pressed():
	if Input.is_action_pressed("shift"):
		for i in range(101):
			var response = makePurchase()
			if !response:
				if i == 0:
					return
				SoundManager.playSound("inventory/purchase",GlobalRef.player.global_position,0.3,0.1)
				AchievementData.unlockMedal("makePurchase")
				return
	
	else:
		if makePurchase():
			SoundManager.playSound("inventory/purchase",GlobalRef.player.global_position,0.3,0.1)
			AchievementData.unlockMedal("makePurchase")
	
func makePurchase() -> bool:
	# check all fail conditions
	if amountAvailable <= 0:
		return false# return of out of stock
	
	var itemData :Item= ItemData.getItem(itemID)
	var handSlot = PlayerData.getHandSlot()
	if handSlot[0] != -1: # if hold slot isn't empty
		if handSlot[0] != itemID:
			return false# return if player holding different item
		# player is holding same item
		if handSlot[1] + 1 > itemData.maxStackSize:
			return false# return if player is holding too much of the item
	
	if PlayerData.money - price < 0:
		updatePriceLabel()
		return false# return if player is broke, add some flair here maybe
	
	PlayerData.spendMoney(price)
	
	handSlot[0] = itemID
	handSlot[1] = max(1,handSlot[1] + 1)
	
	PlayerData.emit_signal("updateInventory")
	
	amountAvailable -= 1
	
	if amountAvailable <= 0:
		$soldOutSprite.show()
		$price.hide()
		$itemSprite.modulate = Color.BLACK
		Saving.shopItems[slotID] = -1
	
	updatePriceLabel()
	
	return true # successful purchase
	
func updatePriceLabel():
	if PlayerData.money - price < 0:
		$price.modulate = Color.FIREBRICK
	else:
		$price.modulate = Color.WHITE
