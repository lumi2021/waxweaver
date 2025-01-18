#ifndef LOOKUPBLOCK_H
#define LOOKUPBLOCK_H

#include <godot_cpp/classes/node.hpp>
#include <godot_cpp/variant/array.hpp>
#include <godot_cpp/variant/dictionary.hpp>
#include <godot_cpp/classes/image.hpp>

//Make sure to include blocks in here too
#include "blockAir.h" // id 0
#include "blockCaveAir.h" // id 1
#include "blockStone.h" // id 2
#include "blockDirt.h" // id 3
#include "blockGrass.h" // id 4
#include "blockCore.h" // id 5
#include "blockPlasma.h" // id 6
#include "blockSapling.h" // id 7
#include "blockTreeLog.h" // id 8
#include "blockLeaves.h" // id 9
#include "blockTreeBranchLeft.h" // id 10
#include "blockTreeBranchRight.h" // id 11
#include "blockTreeBranchLeaf.h" // id 12
#include "blockWood.h" // id 13
#include "blockSand.h" // id 14
#include "blockTorch.h" // id 15
#include "blockFurnace.h" // id 16
#include "blockTallGrass.h" // id 17
#include "blockOreCopper.h" // id 18
#include "blockChair.h" // id 19
#include "blockWorkBench.h" // id 20
#include "blockGlass.h" // id 21
#include "blockDoorClosed.h" // id 22
#include "blockDoorOpen.h" // id 23
#include "blockOreGold.h" // id 24
#include "blockLadder.h" // id 25
#include "blockFlower.h" // id 26
#include "blockOreIron.h" // id 27
#include "blockGravel.h" // id 28
#include "blockBarCopper.h" // id 29
#include "blockBarGold.h" // id 30
#include "blockBarIron.h" // id 31
#include "blockStoneBrick.h" // id 32
#include "blockChest.h" // id 33
#include "blockChestLoot.h" // id 34
#include "blockSoil.h" // id 35
#include "blockSoilDry.h" // id 36
#include "blockCropPotato.h" // id 37
#include "blockCropPotatoNatural.h" // id 38

// paintings batch 1
#include "blockPaintStagPlump.h" // id 39
#include "blockPaintStagMarsh.h" // id 40
#include "blockPaintStagCup.h" // id 41
#include "blockPaintStagDawn.h" // id 42
#include "blockPaintGahAxa.h" // id 43
#include "blockPaintGahFine.h" // id 44
#include "blockPaintGahLuL.h" // id 45

#include "blockGrill.h" // id 46
#include "blockTrapdoorClosed.h" // id 47
#include "blockTrapdoorOpen.h" // id 48

// paintings batch 2
#include "blockPaintLynSmile.h" // id 49
#include "blockPaintLynWorn.h" // id 50
#include "blockPaintLynFish.h" // id 51

#include "blockStalactite.h" // id 52
#include "blockWool.h" // id 53
#include "blockStructure.h" // 54
#include "blockBed.h" // 55
#include "blockSunflowerStem.h" // id 56
#include "blockSunflowerTop.h" // id 57
#include "blockSunflowerLeaf.h" // id 58
#include "blockSunflowerSmall.h" // id 59
#include "blockSunflowerSapling.h" // id 60
#include "blockPaper.h" // id 61
#include "blockLetter.h" // id 62
#include "blockBossShipPillar.h" // id 63
#include "blockVanityPresent.h" // id 64
#include "blockBrownBrick.h" // id 65

// painting batch 3
#include "blockPaintTiltroKiwi.h" // id 66
#include "blockPaintCalvinNightmare.h" // id 67
#include "blockPaintCalvinSunrise.h" // id 68
#include "blockPaintOctoSpiral.h" // id 69
#include "blockPaintKaiaGhosts.h" // id 70
#include "blockPaintKaiaCreature.h" // id 71
#include "blockPaintKaiaWashed.h" // id 72

#include "blockJarFirefly.h" // id 73
#include "blockMoss.h" // id 74
#include "blockMossVine.h" // id 75
#include "blockMossOrb.h" // id 76
#include "blockMossGrass.h" // id 77
#include "blockMagicInfuser.h" // id 78
#include "blockLadderPack.h" // id 79
#include "blockCalcite.h" // id 80
#include "blockAmeCrystal.h" // id 81
#include "blockCoreGrass.h" // id 82
#include "blockCropWheat.h" // id 83
#include "blockSandstone.h" // id 84
#include "blockSnow.h" // id 85
#include "blockIce.h" // id 86
#include "blockCactus.h" // id 87
#include "blockClay.h" // id 88
#include "blockBrick.h" // id 89
#include "blockSeagrass.h" // id 90
#include "blockWire.h" // id 91
#include "blockTeleporter.h" // id 92
#include "blockWireHidden.h" // id 93
#include "blockSolderingIron.h" // id 94
#include "blockLampOn.h" // id 95
#include "blockLampOff.h" // id 96
#include "blockLever.h" // id 97
#include "blockObserver.h" // id 98
#include "blockClock.h" // id 99
#include "blockRepeater.h" // id 100
#include "blockDrill.h" // id 101
#include "blockSpitter.h" // id 102
#include "blockExtender.h" // id 103
#include "blockPlacer.h" // id 104
#include "blockConveyorRight.h" // id 105
#include "blockConveyorLeft.h" // id 106
#include "blockHopper.h" // id 107
#include "blockIceicle.h" // id 108
#include "blockSnowbrick.h" // id 109
#include "blockPineSapling.h" // id 110
#include "blockPineLeaves.h" // id 111
#include "blockPineSolidLeaf.h" // id 112
#include "blockOreFiber.h" // id 113
#include "blockMarble.h" // id 114
#include "blockMarbleBrick.h" // id 115
#include "blockMarblePillar.h" // id 116
#include "blockCampfire.h" // id 117
#include "blockStoneMossy.h" // id 118
#include "blockRockDebris.h" // id 119
#include "blockShelf.h" // id 120
#include "blockBook.h" // id 121
#include "blockTable.h" // id 122
#include "blockFlowerPot.h" // id 123
#include "blockChain.h" // id 124
#include "blockLantern.h" // id 125
#include "blockGrandfatherClock.h" // id 126
#include "blockWindchime.h" // id 127
#include "blockOreFossil.h" // id 128
#include "blockTrinketStation.h" // id 129

// adding a new block? make sure you increment the PENIS array !

namespace godot {

class LOOKUPBLOCK : public Node {
	GDCLASS(LOOKUPBLOCK, Node)

private:
	
protected:
	static void _bind_methods();

public:
	
	Array allBlocks;

	BLOCK *penis[130]; // must be largest id + 1

	LOOKUPBLOCK();
	~LOOKUPBLOCK();
    Dictionary getBlockData(int id);


	bool hasCollision(int id);
	bool isGravityRotate(int id);

	Ref<Image> getTextureImage(int id);

	bool isConnectedTexture(int id);
	bool isTextureConnector(int id);
	bool isMultitile(int id);
	bool isAnimated(int id);
	double getLightMultiplier(int id);
	double getLightEmmission(int id);
	bool isTransparent(int id);
	int getMiningLevel(int id);

	bool isBGImmune(int id);
	bool isOnlyConnectToSelf(int id);

	Dictionary runOnTick(int x, int y, PLANETDATA *planet, int dir, int blockID);
	Dictionary runOnBreak(int x, int y, PLANETDATA *planet, int dir, int blockID);
	Dictionary runOnEnergize(int x, int y, PLANETDATA *planet, int dir, int blockID);

};

}

#endif