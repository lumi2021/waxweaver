extends itemHeldClass

@onready var line = $Line2D
@onready var bobber = $Bobber

var reelOut = false

var delayTick = 0

var bobberVel = Vector2.ZERO

var bobberInWater = false
var bobberWaterTarget = Vector2.ZERO
var bobberWaterPos = Vector2.ZERO

var inWaterTick = 0

var scanningForFish = false

var fishTick :float= 0
var fishTime :float = 2.0

var FOUNDFISH = false
var fishToGive :int= 8

var fishSound :float= 0.0

func onEquip():
	pass

func onFirstUse():
	pass

func onUsing(delta):
	
	if delayTick > 0:
		delayTick -= 1
		onNotUsing(delta)
		return
	
	if reelOut:
		
		if FOUNDFISH:
			var s = get_parent().get_parent().scale.x
			var h = (int(bobber.position.x * s < 0) * 2) - 1
			var v = Vector2(abs(bobber.position.x) * 2.0 * h,-180 - bobber.position.y )
			BlockData.spawnItemVelocity(GlobalRef.currentPlanet.to_local(bobberWaterTarget),fishToGive,GlobalRef.currentPlanet,v)
			SoundManager.playSound("enemy/swim0",bobber.global_position,1.0,0.1)
			reset()
			
		reelIn()

	else:
		# cast line
		castLine()

func onNotUsing(delta):
	
	if delayTick > 0:
		delayTick -= 1
	
	if reelOut:
		if !bobberInWater:
			var vel = bobberVel.rotated( GlobalRef.player.rotated * -(PI/2) )
			vel.y += 1000 * delta
			#vel.y = min(vel.y,200)
			bobberVel = vel.rotated( GlobalRef.player.rotated * (PI/2) )
			bobberWaterPos += bobberVel * delta
			bobber.global_position = bobberWaterPos
			
			var planet = GlobalRef.currentPlanet
			if !is_instance_valid(planet):
				return
			
			var bobWorld = planet.posToTile( planet.to_local( bobber.global_position ) )
			if bobWorld == null:
				return
			
			var water = abs(planet.DATAC.getWaterData(bobWorld.x,bobWorld.y))
			if water > 0.5:
				# HIT WATER
				bobberWaterTarget = planet.to_global(planet.tileToPos( bobWorld ))
				bobberVel *= Vector2(0.25,0.1)
				inWaterTick = 60
				bobberInWater = true
				scanningForFish = true
				SoundManager.playSound("enemy/swim1",bobber.global_position,1.0,0.1)
				rollFishTime()
				
				return
			
			var tile = planet.DATAC.getTileData(bobWorld.x,bobWorld.y)
			if BlockData.checkForCollision(tile):
				# HIT SOLID BLOCK
				bobberVel = Vector2.ZERO
				bobberWaterTarget = planet.to_global(planet.tileToPos( bobWorld ))
				bobberWaterPos = bobberWaterTarget
				bobber.global_position = bobberWaterPos
				bobberInWater = true
				return
		else:
			
			if inWaterTick > 0:
				var vel = bobberVel.rotated( GlobalRef.player.rotated * -(PI/2) )
				vel.y += -20 * delta
				vel = lerp(vel,Vector2.ZERO,0.05)
				bobberVel = vel.rotated( GlobalRef.player.rotated * (PI/2) )
				
				bobberWaterPos += bobberVel * delta
				
				inWaterTick -= 1
				bobber.global_position = bobberWaterPos
			else:
				bobberWaterPos = lerp(bobberWaterPos,bobberWaterTarget,0.01)
				bobber.global_position = bobberWaterPos
			
			
			## FISHING LOOT ## 
			
			if scanningForFish:
				
				fishTick += delta
				if fishTick > fishTime:
					FOUNDFISH = true
					scanningForFish = false
					var data = PlanetTypeInfo.getData(GlobalRef.currentPlanet.planetType)
					fishToGive = data.getFish().id
					$Bobber/CPUParticles2D.emitting = true
					fishTick = 2.0
			
			if FOUNDFISH:
				fishNoise(delta)
				fishTick -= delta
				if fishTick < 0.0:
					reset()
					scanningForFish = true
			
		line.clear_points()
		line.add_point(Vector2.ZERO)
		line.add_point( bobber.position - line.position )

func reelIn():
	
	SoundManager.playSound("items/fishingRodReelIn",bobber.global_position,1.0,0.1)
	
	line.clear_points()
	bobber.visible = false
	delayTick = 30
	reelOut = false
	if scanningForFish:
		SoundManager.playSound("enemy/swim0",bobber.global_position,1.0,0.1)
	bobberInWater = false
	bobber.position = Vector2(17,-5)
	bobberWaterPos = bobber.global_position
	scanningForFish = false

func castLine():
	delayTick = 30
	reelOut = true
	bobber.visible = true
	bobber.position = Vector2(17,-5)
	bobberWaterPos = bobber.global_position
	scanningForFish = false
		
	bobberVel = Vector2(200 * get_parent().get_parent().scale.x,-150).rotated( GlobalRef.player.rotated * (PI/2) )
		
func reset():
	$Bobber/CPUParticles2D.emitting = false
	rollFishTime()
	FOUNDFISH = false

func rollFishTime():
	fishTick = 0.0
	fishTime = randf_range(4.0,12.0)

func fishNoise(delta):
	fishSound += delta
	if fishSound >= 0.2:
		SoundManager.playSound("enemy/swim2",bobber.global_position,1.0,0.1)
		fishSound -= 0.2
