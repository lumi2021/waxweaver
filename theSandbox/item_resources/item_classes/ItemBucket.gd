extends Item
class_name ItemBucket

## 0 = Empty bucket, 1 = Water Bucket, 2 = Infinite Bucket
@export var type = 0

func onUse(tileX:int,tileY:int,planetDir:int,planet,lastTile:Vector2):
	
	if lastTile == Vector2(tileX,tileY) and type < 2:
		return
	
	match type:
		0:
			emptyBucket(tileX,tileY,planetDir,planet,lastTile)
		1:
			fullBucket(tileX,tileY,planetDir,planet,lastTile)
		2:
			magicBucket(tileX,tileY,planetDir,planet,lastTile)
	
func emptyBucket(tileX:int,tileY:int,planetDir:int,planet,lastTile:Vector2):
	
	var waterLevel = abs( planet.DATAC.getWaterData(tileX,tileY) )
	
	if waterLevel > 0.6:
		planet.DATAC.setWaterData(tileX,tileY,0.0)
		PlayerData.replaceSelectedSlot(3026,1)

func fullBucket(tileX:int,tileY:int,planetDir:int,planet,lastTile:Vector2):
	
	
	var waterLevel = abs( planet.DATAC.getWaterData(tileX,tileY) )
	
	if waterLevel < 0.8:
		planet.DATAC.setWaterData(tileX,tileY,0.8)
		PlayerData.replaceSelectedSlot(3025,1)

func magicBucket(tileX:int,tileY:int,planetDir:int,planet,lastTile:Vector2):
	
	planet.DATAC.setWaterData(tileX,tileY,1.0)
