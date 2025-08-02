extends itemHeldClass

var w :float= 8
var h :float= 8

var timeTick :float= 0.0
var timeToEat :float= 1.0

var amountToHeal :int = 1

var soundTick :float= 0.0

func onEquip():
	visible = false
	sprite.region_rect.size.x = sprite.texture.get_width()
	sprite.region_rect.size.y = sprite.texture.get_height()
	w = sprite.region_rect.size.x
	h = sprite.region_rect.size.y
	
	timeToEat = itemData.eatTime
	amountToHeal = itemData.healingAmount
	$origin/CPUParticles2D.modulate = itemData.particleColor

func onFirstUse():
	visible = false
	sprite.region_rect.position.x = 0.0
	sprite.region_rect.position.y = 0.0
	sprite.region_rect.size.x = sprite.texture.get_width()
	sprite.region_rect.size.y = sprite.texture.get_height()
	w = sprite.region_rect.size.x
	h = sprite.region_rect.size.y

func onUsing(delta):
	visible = true
	timeTick += delta
	
	var ratio = timeTick / timeToEat
	
	sprite.region_rect.position.x = ratio * w
	sprite.region_rect.size.x = w - (ratio * w)
	
	if timeTick >= timeToEat:
		timeTick = 0.0
		onFirstUse()
		GlobalRef.player.healthComponent.heal(amountToHeal)
		
		for effect in itemData.statusInflictors:
			var chance :int= (randi() % 100) + 1
			if chance <= effect.chance:
				GlobalRef.player.healthComponent.inflictStatus( effect.effectName, effect.seconds )
		
		
		PlayerData.consumeSelected()
		SoundManager.playSound("items/eatFood2",global_position,1.5,0.1)
		SoundManager.playSound("items/heal",global_position,1.5,0.0)
	
	# play sound
	soundTick += delta
	if soundTick > 0.3:
		soundTick -= 0.3
		#var r = str((randi() % 2 ) + 1)
		SoundManager.playSound("items/eatFood1",global_position,1.7,0.2)
	

func onNotUsing(delta):
	visible = false
	timeTick = 0.0
