extends itemHeldClass

@onready var rotOrigin = $holder
@onready var line = $preview/Line2D

var rotSpeed = 10.0

var swingOut = false

var size = Vector2(1,1)

func onEquip():
	# determine outline size
	size = itemData.size
	
	line.add_point( Vector2.ZERO )
	line.add_point( Vector2( size.x * 8, 0 ) )
	line.add_point( size * 8 )
	line.add_point( Vector2( 0, size.y * 8 ) )
	
	line.position.y = (size.y * -8) + 4
	
	override = true
	rotOrigin.visible = false
	isVisible = false
	sprite.texture = itemData.texture
	visible = true
	

func onFirstUse():
	if swingOut:
		return
	rotOrigin.rotation_degrees = -60.0
	rotOrigin.visible = true
	isVisible = true
	swingOut = true

func onUsing(delta):
	always()
	rotOrigin.rotation_degrees += rotSpeed * delta * 60.0
	if rotOrigin.rotation_degrees > 50:
		if !clickUsage:
			rotOrigin.rotation_degrees = -60.0
		else:
			swingOut = false
			turnOff()

func onNotUsing(delta):
	always()
	if swingOut:
		rotOrigin.rotation_degrees += rotSpeed * delta * 60.0
		if rotOrigin.rotation_degrees > 50:
			swingOut = false
			turnOff()
	else:
		turnOff()

func turnOff():
	isVisible = false
	rotOrigin.visible = false

func always():
	var globMouse = get_global_mouse_position()
	var planet = GlobalRef.player.planetOn
	if !is_instance_valid(planet):
		planet = GlobalRef.player.shipOn
		if !is_instance_valid(planet):
			return
	
	var pos = planet.posToTile( planet.to_local(globMouse) )
	
	if pos == null:
		return
	
	var rev = planet.tileToPos( pos )
	
	$preview.global_position = planet.global_position + rev
	$preview.scale.x = get_parent().get_parent().scale.x
	
	$preview.visible = PlayerData.getSelectedItemID() == itemID
		
	
