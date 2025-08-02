extends Item
class_name ItemPermanentUpgrade

enum upgradeEnum {PRAFFINBOSS,WORMBOSS,FINALBOSS}
@export var upgradeToBestow :upgradeEnum

func onUse(tileX:int,tileY:int,planetDir:int,planet,lastTile:Vector2):
	match upgradeToBestow:
		upgradeEnum.PRAFFINBOSS:
			if !GlobalRef.claimedPraffinBossPrize:
				GlobalRef.claimedPraffinBossPrize = true
				PlayerData.emit_signal("armorUpdated")
				PlayerData.consumeSelected()
				GlobalRef.player.healthComponent.heal(50)
				GlobalRef.player.spawnGiftParticle()
		upgradeEnum.WORMBOSS:
			if !GlobalRef.claimedWormBossPrize:
				GlobalRef.claimedWormBossPrize = true
				PlayerData.emit_signal("armorUpdated")
				PlayerData.consumeSelected()
				GlobalRef.player.healthComponent.heal(50)
				GlobalRef.player.spawnGiftParticle()
		upgradeEnum.FINALBOSS:
			if !GlobalRef.claimedFinalBossPrize:
				GlobalRef.claimedFinalBossPrize = true
				PlayerData.emit_signal("armorUpdated")
				PlayerData.consumeSelected()
				GlobalRef.player.healthComponent.heal(100)
				GlobalRef.player.spawnGiftParticle()
