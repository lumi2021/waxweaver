extends Resource
class_name Item

@export var id := 0
@export var texture : Texture

@export var maxStackSize := 99

## FALSE means item can be used continually while mouse is held down,TRUE means its only used once.
@export var clickToUse := false

## Crafting recipe ids that this item is used in
@export var materialIn : Array[int] = []

func onUse(tileX:int,tileY:int,planetDir:int,planet:Planet,lastTile:Vector2):
	pass
