extends Node

@onready var groundItemScene = preload("res://object_scenes/ground_item/ground_item.tscn")
@onready var blockBreakParticle = preload("res://object_scenes/particles/blockBreak/block_break_particles.tscn")

var theChunker = null
var theGenerator = null

func _ready():
	var ins = CHUNKDRAW.new()
	theChunker = ins
	add_child(ins)
	
	var g = PLANETGEN.new()
	theGenerator = g
	add_child(g)
	
	theChunker.attemptSpawnEnemy.connect(attemptSpawnEnemy)

func attemptSpawnEnemy(planet,tile:Vector2,blockID:int,dir:int):
	var bro = tile + Vector2(0,1).rotated((PI/2)*dir)
	if planet.getTileData(bro.x,bro.y) > 1:
		var ins = load("res://object_scenes/entity/enemy.tscn").instantiate()
		ins.position = planet.get_parent().tileToPos(tile)
		planet.get_parent().entityContainer.add_child(ins)
		#print("GOOBER SPAWNED AT : " + str(tile))

func breakBlock(x,y,planet,blockID):
	
	var data = theChunker.getBlockDictionary(blockID)
	
	spawnBreakParticle(x,y,blockID,data["breakParticleID"],planet)
	spawnGroundItem(x,y,data["itemToDrop"],planet)
	
	planet.editTiles( theChunker.runBreak(planet.DATAC,Vector2i.ZERO,x,y,blockID) )

func breakWall(x,y,planet,blockID):
	
	var data = theChunker.getBlockDictionary(blockID)
	spawnBreakParticle(x,y,blockID,data["breakParticleID"],planet)


func spawnGroundItem(tilex:int,tiley:int,id:int,planet):
	if id == -1:
		return
	var ins = groundItemScene.instantiate()
	ins.itemID = id
	ins.position = planet.tileToPos(Vector2(tilex,tiley))
	planet.entityContainer.add_child(ins)

func spawnBreakParticle(tilex:int,tiley:int,id:int,otherId:int,planet):
	
	var newId = id
	if otherId != -1:
		newId = otherId
	
	var ins = blockBreakParticle.instantiate()
	ins.textureID = newId
	ins.position = planet.tileToPos(Vector2(tilex,tiley))
	planet.entityContainer.add_child(ins)
