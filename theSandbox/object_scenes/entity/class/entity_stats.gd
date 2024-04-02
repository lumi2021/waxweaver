extends Node

##  This script handles enemy and player data like:  ##
##    health, max health, defense, status effects,   ##
##      knockback resistence, attack damage, etc     ##

@export var maxHealth := 100
@export var defense := 0
@export var knockbackResist := 0
@export var attackDamage := 10

var currentHealth = maxHealth

@onready var parent = get_parent()
var enemyResource = null

func damage(amount):
	currentHealth -= max( 1 , amount - defense ) #subtract defense from damage amount
	# add code for cool hitmarker
	parent.updateHealth()
