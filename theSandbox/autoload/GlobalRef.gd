extends Node

var player : Player = null
var camera = null
var system  = null
var lightmap = null

var gravityConstant : float = 2000

var fastTick : float = 0.0
var globalTick : int = 0

var playerSide = 0 # 0 : facing left, 1 : facing right


func _physics_process(delta):
	fastTick += 1
	if fastTick >= 4:
		globalTick += 1
		fastTick = 0
