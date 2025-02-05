extends Item
class_name ItemSummoner

@export var bossToSummon :String = ""

func onUse(tileX:int,tileY:int,planetDir:int,planet,lastTile:Vector2):
	if CreatureData.spawnBoss(planet,Vector2.ZERO,bossToSummon):
		PlayerData.consumeSelected()
