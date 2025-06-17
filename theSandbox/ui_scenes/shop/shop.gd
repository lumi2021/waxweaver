extends Node2D

@onready var slotScene = preload("res://ui_scenes/shop/shop_slot.tscn")

var deals = [
	{"id":7,"price":5,"stock":99},
	{"id":3,"price":1,"stock":9900},
	{"id":15,"price":2,"stock":99},
	{"id":17,"price":3,"stock":99},
	{"id":29,"price":8,"stock":99},
	{"id":26,"price":10,"stock":10},
	{"id":37,"price":8,"stock":10},
	{"id":25,"price":3,"stock":99},
	{"id":21,"price":6,"stock":99},
	{"id":60,"price":10,"stock":10},
	{"id":62,"price":15,"stock":99},
	{"id":73,"price":15,"stock":10},
	{"id":79,"price":30,"stock":10},
	{"id":87,"price":20,"stock":5},
	{"id":88,"price":8,"stock":99},
	{"id":110,"price":10,"stock":5},
	{"id":117,"price":30,"stock":2},
	{"id":121,"price":15,"stock":10},
	{"id":124,"price":10,"stock":10},
	{"id":125,"price":30,"stock":10},
	{"id":126,"price":60,"stock":1},
	{"id":127,"price":60,"stock":1},
	{"id":114,"price":10,"stock":99},
	{"id":3000,"price":5,"stock":1},
	{"id":3001,"price":5,"stock":1},
	{"id":3003,"price":6,"stock":99},
	{"id":3004,"price":8,"stock":99},
	{"id":3023,"price":2,"stock":99},
	{"id":3026,"price":20,"stock":1},
	{"id":3027,"price":999,"stock":1},
	{"id":3031,"price":30,"stock":5},
	{"id":3040,"price":30,"stock":10},
	{"id":3053,"price":35,"stock":10},
	{"id":3078,"price":50,"stock":1},
	{"id":3095,"price":999,"stock":5},
	{"id":3124,"price":200,"stock":1},
	{"id":3125,"price":40,"stock":10},
	{"id":3135,"price":20,"stock":99},
	{"id":3169,"price":15,"stock":99},
	{"id":95,"price":30,"stock":3},
	{"id":97,"price":20,"stock":3},
	{"id":98,"price":30,"stock":3},
	{"id":99,"price":30,"stock":3},
	{"id":100,"price":30,"stock":3},
	{"id":101,"price":30,"stock":3},
	{"id":102,"price":30,"stock":3},
	{"id":103,"price":30,"stock":3},
	{"id":104,"price":30,"stock":3},
	{"id":105,"price":20,"stock":10},
	{"id":107,"price":30,"stock":3},
	{"id":91,"price":15,"stock":10},
	{"id":3076,"price":10,"stock":1},
	{"id":30,"price":20,"stock":20},
	{"id":160,"price":25,"stock":10},
	{"id":161,"price":25,"stock":5},
	
	{"id":6230,"price":3,"stock":99}, # shingles
	{"id":6231,"price":3,"stock":99},
	{"id":6232,"price":3,"stock":99},
	{"id":6233,"price":3,"stock":99},
	{"id":6234,"price":3,"stock":99},
	{"id":6235,"price":3,"stock":99},
	
	{"id":141,"price":2,"stock":99},
	{"id":135,"price":25,"stock":5},
	{"id":74,"price":5,"stock":99},
	{"id":3196,"price":10,"stock":20},
	{"id":3221,"price":20,"stock":99},
	{"id":168,"price":10,"stock":99},
	
	{"id":-143,"price":1,"stock":999}, # wallpapers
	{"id":-144,"price":1,"stock":999},
	{"id":-145,"price":1,"stock":999},
	{"id":-146,"price":1,"stock":999},
]

var rareDeals = [
	{"id":3085,"price":200,"stock":1}, # naked armor
	{"id":3086,"price":200,"stock":1},
	{"id":3087,"price":200,"stock":1},
	
	{"id":39,"price":200,"stock":1}, # paintings
	{"id":40,"price":200,"stock":1},
	{"id":41,"price":200,"stock":1},
	{"id":42,"price":200,"stock":1},
	{"id":43,"price":200,"stock":1},
	{"id":44,"price":200,"stock":1},
	{"id":45,"price":200,"stock":1},
	{"id":49,"price":200,"stock":1},
	{"id":50,"price":200,"stock":1},
	{"id":51,"price":200,"stock":1},
	{"id":66,"price":200,"stock":1},
	{"id":67,"price":200,"stock":1},
	{"id":68,"price":200,"stock":1},
	{"id":69,"price":200,"stock":1},
	{"id":70,"price":200,"stock":1},
	{"id":71,"price":200,"stock":1},
	{"id":72,"price":200,"stock":1},
	{"id":154,"price":200,"stock":1},
	{"id":155,"price":200,"stock":1},
	{"id":156,"price":200,"stock":1},
	{"id":157,"price":200,"stock":1},
	{"id":158,"price":200,"stock":1},
	{"id":159,"price":200,"stock":1},
	
	{"id":3033,"price":300,"stock":1}, # trinkets
	{"id":3034,"price":300,"stock":1},
	{"id":3036,"price":300,"stock":1},
	{"id":3066,"price":300,"stock":1},
	{"id":3067,"price":300,"stock":1},
	{"id":3068,"price":300,"stock":1},
	{"id":3069,"price":250,"stock":1},
	{"id":3137,"price":300,"stock":1},
	{"id":3138,"price":300,"stock":1},
	{"id":3139,"price":400,"stock":1},
	{"id":3140,"price":400,"stock":1},
	{"id":3141,"price":300,"stock":1},
	{"id":3142,"price":300,"stock":1},
	{"id":3147,"price":300,"stock":1},
	{"id":3162,"price":500,"stock":1},
	{"id":3161,"price":200,"stock":1},
	{"id":3163,"price":200,"stock":1},
	{"id":3164,"price":200,"stock":1},
	{"id":3165,"price":200,"stock":1},
	{"id":3166,"price":200,"stock":1},
	{"id":3167,"price":200,"stock":1},
	{"id":3197,"price":200,"stock":1},
	
	{"id":3010,"price":100,"stock":1}, # vanity
	{"id":3022,"price":100,"stock":1},
	{"id":3079,"price":100,"stock":1},
	{"id":3080,"price":100,"stock":1},
	{"id":3081,"price":100,"stock":1},
	{"id":3082,"price":100,"stock":1},
	{"id":3083,"price":100,"stock":1},
	{"id":3084,"price":100,"stock":1},
	{"id":3088,"price":100,"stock":1},
	{"id":3089,"price":100,"stock":1},
	{"id":3090,"price":100,"stock":1},
	{"id":3096,"price":100,"stock":1},
	{"id":3097,"price":100,"stock":1},
	{"id":3098,"price":100,"stock":1},
	{"id":3099,"price":100,"stock":1},
	{"id":3100,"price":100,"stock":1},
	{"id":3101,"price":100,"stock":1},
	{"id":3102,"price":100,"stock":1},
	{"id":3103,"price":100,"stock":1},
	{"id":3104,"price":100,"stock":1},
	{"id":3105,"price":100,"stock":1},
	{"id":3106,"price":100,"stock":1},
	{"id":3107,"price":100,"stock":1},
	{"id":3108,"price":100,"stock":1},
	{"id":3109,"price":100,"stock":1},
	{"id":3110,"price":100,"stock":1},
	{"id":3111,"price":100,"stock":1},
	{"id":3112,"price":100,"stock":1},
	{"id":3113,"price":100,"stock":1},
	{"id":3114,"price":100,"stock":1},
	{"id":3115,"price":100,"stock":1},
	{"id":3116,"price":100,"stock":1},
	{"id":3117,"price":100,"stock":1},
	{"id":3118,"price":100,"stock":1},
	{"id":3119,"price":100,"stock":1},
	{"id":3120,"price":100,"stock":1},
	{"id":3121,"price":100,"stock":1},
	{"id":3122,"price":100,"stock":1},
	{"id":3123,"price":100,"stock":1},
	{"id":3201,"price":100,"stock":1},
	{"id":3202,"price":100,"stock":1},
	{"id":3203,"price":100,"stock":1},
	{"id":3204,"price":100,"stock":1},
	{"id":3205,"price":100,"stock":1},
	{"id":3206,"price":100,"stock":1},
	{"id":3207,"price":100,"stock":1},
	{"id":3208,"price":100,"stock":1},
	{"id":3209,"price":100,"stock":1},
	{"id":3210,"price":100,"stock":1},
	{"id":3211,"price":100,"stock":1},
	{"id":3212,"price":100,"stock":1},
	
	
	{"id":6001,"price":100,"stock":1}, # toilet
]

var rerollTween = null

func _ready():
	GlobalRef.connect("newDay",generateShopItems)
	await get_tree().create_timer(0.2).timeout
	loadFreshShopItems()

func generateShopItems():
	
	for child in $HBoxContainer.get_children():
		child.queue_free()
		
	var sale = randi() % 6
	
	var shopItems :Array= []
	
	for i in range(6):
		var ins = slotScene.instantiate()
		ins.slotID = i
		if i <= 1:
			var sampleID = randi() % rareDeals.size()
			var item:Dictionary = rareDeals[sampleID]
			ins.itemID = item["id"]
			ins.price = item["price"]
			ins.amountAvailable = item["stock"]
			shopItems.append(sampleID)
		else:
			var sampleID = randi() % deals.size()
			var item:Dictionary = deals[sampleID]
			ins.itemID = item["id"]
			ins.price = item["price"]
			ins.amountAvailable = item["stock"]
			shopItems.append(sampleID)
		
		if sale == i:
			ins.onSale = true
		$HBoxContainer.add_child(ins)
	
	shopItems.append(sale)
	Saving.shopItems = shopItems
	
	if GlobalRef.hotbar.isShopVisible():
		SoundManager.playSound("blocks/computer",GlobalRef.player.global_position,0.8)

func loadFreshShopItems():
	if Saving.shopItems.size() < 7: # if shop is empty or invalid
		generateShopItems() # generate new items
		return
	
	for i in range(6):
		var ins = slotScene.instantiate()
		ins.slotID = i
		if i <= 1:
			var sampleID = Saving.shopItems[i]
			if sampleID == -1:
				ins.forceStock = true
				sampleID = 0
			var item:Dictionary = rareDeals[sampleID]
			ins.itemID = item["id"]
			ins.price = item["price"]
			ins.amountAvailable = item["stock"]
		else:
			var sampleID = Saving.shopItems[i]
			if sampleID == -1:
				ins.forceStock = true
				sampleID = 0
			var item:Dictionary = deals[sampleID]
			ins.itemID = item["id"]
			ins.price = item["price"]
			ins.amountAvailable = item["stock"]
		
		if Saving.shopItems[6] == i:
			ins.onSale = true
		$HBoxContainer.add_child(ins)
	


func _on_rerolll_pressed():
	if !PlayerData.spendMoney(200):
		return
	generateShopItems()
	if rerollTween != null:
		if rerollTween.is_running():
			return
	$Shuffle.rotation = 0.0
	rerollTween = get_tree().create_tween()
	rerollTween.tween_property($Shuffle,"rotation",PI * -2.0,1.0).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
