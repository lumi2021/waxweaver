extends Node

var data = {
	-1:null,
	# block items
	0:load("res://items/blocks/natural/StoneItem.tres"),
	2:load("res://items/blocks/natural/StoneItem.tres"),
	3:load("res://items/blocks/natural/DirtItem.tres"),
	5:load("res://items/blocks/natural/CoreItem.tres"),
	7:load("res://items/blocks/foliage/SaplingItem.tres"),
	13:load("res://items/blocks/building/WoodItem.tres"),
	-13:load("res://items/walls/WoodWallItem.tres"),
	14:load("res://items/blocks/natural/SandItem.tres"),
	15:load("res://items/torches/TorchItem.tres"),
	16:load("res://items/blocks/furniture/stations/Furnace.tres"),
	18:load("res://items/blocks/ores/CopperOre.tres"),
	20:load("res://items/blocks/furniture/stations/WorkBench.tres"),
	21:load("res://items/blocks/building/GlassItem.tres"),
	-21:load("res://items/walls/GlassWallItem.tres"),
	24:load("res://items/blocks/ores/GoldOre.tres"),
	25:load("res://items/blocks/furniture/other/Ladder.tres"),
	26:load("res://items/blocks/foliage/flowers/LilyItem.tres"),
	27:load("res://items/blocks/ores/IronOre.tres"),
	28:load("res://items/blocks/natural/GravelItem.tres"),
	
	29:load("res://items/material/bars/CopperBar.tres"),
	30:load("res://items/material/bars/GoldBar.tres"),
	31:load("res://items/material/bars/IronBar.tres"),
	
	32:load("res://items/blocks/building/StoneBrick.tres"),
	-32:load("res://items/walls/StoneBrickWall.tres"),
	
	35:load("res://items/blocks/natural/SoilItem.tres"),
	37:load("res://items/blocks/foliage/crops/Potato.tres"),
	
	# paintings batch 1
	39:load("res://items/paintings/StagPlump.tres"),
	40:load("res://items/paintings/StagMarsh.tres"),
	41:load("res://items/paintings/StagCup.tres"),
	42:load("res://items/paintings/StagDawn.tres"),
	43:load("res://items/paintings/GahAxa.tres"),
	44:load("res://items/paintings/GahFine.tres"),
	45:load("res://items/paintings/GahLUL.tres"),
	
	46:load("res://items/blocks/furniture/stations/Grill.tres"),
	47:load("res://items/blocks/furniture/trapdoors/ItemTrapdoor.tres"),
	
	# painting batch 2
	49:load("res://items/paintings/LynSmile.tres"),
	50:load("res://items/paintings/LynWorn.tres"),
	51:load("res://items/paintings/LynFish.tres"),
	
	54:load("res://items/blocks/technical/StructureBlock.tres"),
	
	59:load("res://items/blocks/foliage/trees/sunflowerTree/sunflower.tres"),
	60:load("res://items/blocks/foliage/trees/sunflowerTree/sunflowerSapling.tres"),
	61:load("res://items/blocks/building/Paper.tres"),
	-61:load("res://items/walls/PaperWall.tres"),
	62:load("res://items/blocks/building/LetterBlock.tres"),
	
	########## item ids ##################
	3000:load("res://items/tools/flimsy/FlimsySword.tres"), # flimsy tools
	3001:load("res://items/tools/flimsy/FlimsyPickaxe.tres"),
	3002:load("res://items/tools/hammers/Mallet.tres"),
	
	3003:load("res://items/material/Wax.tres"),
	3004:load("res://items/material/String.tres"),
	3005:null,
	
	3006:load("res://items/tools/copper/CopperSword.tres"), # copper tools
	3007:load("res://items/tools/copper/CopperPickaxe.tres"),
	
	3008:load("res://items/tools/golden/GoldenSword.tres"), # golden tools
	3009:load("res://items/tools/golden/GoldenPickaxe.tres"),
	
	3010:load("res://items/vanity/redTie/RedTie.tres"),
	3011:load("res://items/tools/iron/IronSword.tres"), # iron tools
	3012:load("res://items/tools/iron/IronPickaxe.tres"),
	
	3013:load("res://items/armors/copper/CopperHelmet.tres"),
	3014:load("res://items/armors/copper/CopperChestplate.tres"),
	3015:load("res://items/armors/copper/CopperLegs.tres"),
	
	3016:load("res://items/armors/gold/GoldHelmet.tres"),
	3017:load("res://items/armors/gold/GoldChest.tres"),
	3018:load("res://items/armors/gold/GoldLegs.tres"),
	
	3019:load("res://items/armors/iron/IronHelmet.tres"),
	3020:load("res://items/armors/iron/IronChest.tres"),
	3021:load("res://items/armors/iron/IronLeggings.tres"),
	
	3022:load("res://items/vanity/butterflyPin/PinkBFPin.tres"),
	
	3023:load("res://items/weapons/arrows/Arrow.tres"),
	3024:load("res://items/weapons/bows/WoodenBow.tres"),
	
	3025:load("res://items/tools/bucket/EmptyBucket.tres"),
	3026:load("res://items/tools/bucket/FullBucket.tres"),
	3027:load("res://items/tools/bucket/MagicBucket.tres"),
	
	3028:load("res://items/food/PotatoBaked.tres"),
	3029:load("res://items/tools/fishingRods/WoodRod.tres"),
	3030:load("res://items/fish/Catfish.tres"),
	3031:load("res://items/food/FishCatGrilled.tres"),
	3032:load("res://items/food/FishAndChips.tres"),
	3033:load("res://items/trinket/SpringShoes.tres"),
	3034:load("res://items/trinket/ComftySocks.tres"),
	3035:load("res://items/weapons/arrows/GoldenArrow.tres"),
	3036:load("res://items/trinket/GoldenRing.tres"),
	3037:load("res://items/food/Apple.tres"),
	3038:load("res://items/trinket/Flashlight.tres"),
	3039:load("res://items/weapons/arrows/PoisonArrow.tres"),
	3040:load("res://items/tools/explosives/bomb.tres"),
	
	3041:load("res://items/blocks/building/colors/wools/RedWool.tres"), # wools
	3042:load("res://items/blocks/building/colors/wools/OrangeWool.tres"),
	3043:load("res://items/blocks/building/colors/wools/YellowWool.tres"),
	3044:load("res://items/blocks/building/colors/wools/GreenWool.tres"),
	3045:load("res://items/blocks/building/colors/wools/CyanWool.tres"),
	3046:load("res://items/blocks/building/colors/wools/BlueWool.tres"),
	3047:load("res://items/blocks/building/colors/wools/PurpleWool.tres"),
	3048:load("res://items/blocks/building/colors/wools/WhiteWool.tres"),
	3049:load("res://items/blocks/building/colors/wools/GreyWool.tres"),
	3050:load("res://items/blocks/building/colors/wools/BlackWool.tres"),
	3051:load("res://items/blocks/building/colors/wools/BrownWool.tres"),
	3052:load("res://items/blocks/building/colors/wools/PinkWool.tres"),
	
	3053:load("res://items/gifts/DyeBag.tres"),
	
	3054:load("res://items/dye/DyeRed.tres"), # dyes
	3055:load("res://items/dye/DyeOrange.tres"),
	3056:load("res://items/dye/DyeYellow.tres"),
	3057:load("res://items/dye/DyeGreen.tres"),
	3058:load("res://items/dye/DyeCyan.tres"),
	3059:load("res://items/dye/DyeBlue.tres"),
	3060:load("res://items/dye/DyePurple.tres"),
	3061:load("res://items/dye/DyeWhite.tres"),
	3062:load("res://items/dye/DyeGrey.tres"),
	3063:load("res://items/dye/DyeBlack.tres"),
	3064:load("res://items/dye/DyeBrown.tres"),
	3065:load("res://items/dye/DyePink.tres"),
	
	3066:load("res://items/trinket/Dice.tres"),
	3067:load("res://items/trinket/BoxingGlove.tres"),
	3068:load("res://items/trinket/BandAid.tres"),
	3069:load("res://items/trinket/Flipper.tres"),
	3070:load("res://items/trinket/curses/CurseStone.tres"),
	3071:load("res://items/trinket/curses/CurseFragile.tres"),
	3072:load("res://items/trinket/curses/CurseMoonwalk.tres"),
	
	3073:load("res://items/tools/sunflower/SunflowerSword.tres"),
	3074:load("res://items/tools/sunflower/SunflowerPickaxe.tres"),
	
	3075:load("res://items/vanity/propellerCap/PropellerCap.tres"),
	3076:load("res://items/tools/bossSummoner/WaxLollipop.tres"),
	3077:load("res://items/gifts/Crate.tres"),
	
	# chairs 6000 - 6049
	6000:load("res://items/blocks/furniture/chairs/WoodenChair.tres"),
	6001:load("res://items/blocks/furniture/chairs/Toilet.tres"),
	
	# doors 6050 - 6099
	6050:load("res://items/blocks/furniture/doors/WoodDoor.tres"),
	6051:load("res://items/tools/golden/GoldenPickaxe.tres"),
	
	# chests 6100 - 6149
	6100:load("res://items/blocks/furniture/chests/WoodenChest.tres"),
	
	# beds 6150 - 6200
	6150:load("res://items/blocks/furniture/beds/WhiteBed.tres"),
}

var heldItemAnims = {
	"itemSwing" : load("res://item_resources/item_held_scenes/item_swing.tscn"),
	"itemBow" : load("res://item_resources/item_held_scenes/item_bow.tscn"),
	"itemSwingNoHitbox" : load("res://item_resources/item_held_scenes/itemSwingNoHitbox.tscn"),
	"itemFood" : load("res://item_resources/item_held_scenes/item_food.tscn"),
	"itemTorch" : load("res://item_resources/item_held_scenes/item_torch.tscn"),
	"itemMultitile" : load("res://item_resources/item_held_scenes/itemMultitile.tscn"),
	"itemFishingRod" : load("res://item_resources/item_held_scenes/item_fish_rod.tscn"),
	"itemTossable" : load("res://item_resources/item_held_scenes/itemTossable.tscn")
}

func matchItemAnimation(id):
	var d = getItem(id)
	if d is ItemBlock or d is ItemPlant or d is ItemBucket or d is ItemTypeBlock:
		return "itemSwingNoHitbox"
	if d is ItemDamage:
		return "itemSwing"
	if d is ItemBow:
		return "itemBow"
	if d is ItemFood:
		return "itemFood"
	if d is ItemTorch:
		return "itemTorch"
	if d is ItemMultitile or d is ItemDoor or d is ItemChair or d is ItemBed:
		return "itemMultitile"
	if d is ItemFishingRod:
		return "itemFishingRod"
	if d is ItemTossable:
		return "itemTossable"
	
	return null

func getItem(id):
	if data.has(id):
		return data[id]
	return data[0]

func itemExists(id):
	return data.has(id)

func getItemName(id):
	var d = getItem(id)
	if !is_instance_valid(d):
		return ""
	return d.itemName

func getItemTexture(id):
	var d = getItem(id)
	if !is_instance_valid(d):
		return ""
	return d.texture
