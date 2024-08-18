extends Item
class_name ItemTrinket

## description of what trinket does
@export_multiline var description :String = ""

@export var specialProperties :Array[String]

## scene to load on player, leave empty for none
@export var sceneToLoad :String = ""

@export_group("Stats")
@export_subgroup("Movement")
@export var addSpeed :float = 0.0
@export var addJump :float = 0.0
@export var addSwim :float = 0.0
@export_subgroup("Combat")
@export var addDefense :int = 0
@export var addMeleeDamage :float = 0.0
@export var addRangedDamage :float = 0.0
@export var addHealingMultiplier :float = 0.0

