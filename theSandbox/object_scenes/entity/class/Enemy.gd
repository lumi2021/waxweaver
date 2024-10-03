extends CharacterBody2D
class_name Enemy

@export var creatureSlots :int= 5
@export var passive :bool= false

var planet = null

func getPos():
	return planet.posToTile(position)

func getTile():
	var pos = getPos()
	
	if pos == null:
		return 0
	
	return planet.DATAC.getTileData(pos.x,pos.y)

func getWater():
	var pos = getPos()
	
	if pos == null:
		return 0.0
	
	return abs(planet.DATAC.getWaterData(pos.x,pos.y))

func getWall():
	var pos = getPos()
	
	if pos == null:
		return 0
	
	return planet.DATAC.getBGData(pos.x,pos.y)

func getLight():
	var pos = getPos()
	
	if pos == null:
		return 1.0
	
	return planet.DATAC.getLightData(pos.x,pos.y)

func setLight(amount):
	var pos = getPos()
	
	if pos == null:
		return
	
	if getLight() > amount:
		return
	planet.DATAC.setLightData(pos.x,pos.y,-amount)

func getQuad(obj):
	
	var pos = getPos()
	if pos == null:
		var angle1 = Vector2(1,1)
		var angle2 = Vector2(-1,1)
			
		var dot1 = int(obj.position.dot(angle1) >= 0)
		var dot2 = int(obj.position.dot(angle2) > 0) * 2
		
		return [0,1,3,2][dot1 + dot2]
	
	return planet.DATAC.getPositionLookup(pos.x,pos.y)
		

func getDirectionTowardsPlayer():
	var myQuad = getQuad( self )
	var playerQuad = getQuad( GlobalRef.player )
		
	var pose = self.position.rotated((PI/2)*-myQuad)
	var posa = GlobalRef.player.position.rotated((PI/2)*-playerQuad)
	var targetdir :int= ((int(pose.x < posa.x) * 2.0) - 1.0)
		
	if playerQuad != myQuad:
		targetdir *= -1
	return targetdir

func getPlayerDistance():
	var x = abs( GlobalRef.player.position.x - position.x )
	var y = abs( GlobalRef.player.position.y - position.y )
	return Vector2(x,y).length()

func getVelocity():
	return velocity.rotated( -(PI/2) * getQuad(self)  )

func setVelocity(vel):
	velocity = vel.rotated( (PI/2) * getQuad(self)  )

func getVERTICALDirectionTowardsPlayer():
	var myQuad = getQuad( self )
	var playerQuad = getQuad( GlobalRef.player )
		
	var pose = self.position.rotated((PI/2)*-myQuad)
	var posa = GlobalRef.player.position.rotated((PI/2)*-playerQuad)
	var targetdir :int= ((int(pose.y < posa.y) * 2.0) - 1.0)
		
	if playerQuad != myQuad:
		targetdir *= -1
	return targetdir

func getExactDirToPlayer():
	return (GlobalRef.player.position - position).normalized()

func getSurface():
	var pos = getPos()
	
	if pos == null:
		return 0
	
	return planet.getSurfaceDistance(pos.x,pos.y)
