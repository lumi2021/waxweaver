extends itemHeldClass

@onready var rotOrigin = $origin

var rotSpeed = 10.0

var swingOut = false

var doneFullSwing :int= false

func onEquip():
	visible = true
	$AnimationPlayer.play("torch")
	$origin/Sprite2D.texture = BlockData.theChunker.getBlockDictionary(itemData.blockID)["texture"]

func onFirstUse():
	if swingOut:
		return
	rotOrigin.rotation_degrees = -60.0
	swingOut = true

func onUsing(delta):
	always()
	
	if !doneFullSwing:
		rotOrigin.rotation_degrees += rotSpeed * delta * 60.0
	if rotOrigin.rotation_degrees > 50:
		rotOrigin.rotation_degrees = -60.0
		swingOut = false
		doneFullSwing = true
		turnOff()

func onNotUsing(delta):
	always()
	doneFullSwing = false
	if swingOut:
		rotOrigin.rotation_degrees += rotSpeed * delta * 60.0
		if rotOrigin.rotation_degrees > 50:
			swingOut = false
			turnOff()
	else:
		turnOff()
	
func turnOff():
	rotOrigin.rotation = 0.0

func always():
	
	if usedUp:
		visible = false
		return
	
	var planet = GlobalRef.player.planetOn
	if planet == null:
		return
	var p = planet.posToTile(GlobalRef.player.position)
	var l = planet.DATAC.getLightData(p.x,p.y)
	if l > 1.2:
		return
	planet.DATAC.setLightData(p.x,p.y,-1.2)
