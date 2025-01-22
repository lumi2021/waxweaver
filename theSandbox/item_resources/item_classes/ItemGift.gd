extends Item
class_name ItemGift

@export var loottable :Loot

func onUse(tileX:int,tileY:int,planetDir:int,planet,lastTile:Vector2):
	var items :Array[LootItem] = loottable.getLoot()
	PlayerData.consumeSelected()
	for item in items:
		PlayerData.addItem(item.id,item.amount)
		print( "Loot found: " + str(item.amount) + " " + ItemData.getItemName(item.id) )
		
		Indicators.itemPopup(ItemData.getItemName(item.id),item.amount,GlobalRef.player.global_position)
		
	GlobalRef.player.spawnGiftParticle()
