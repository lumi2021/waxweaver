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

// adding a new block? make sure you increment the PENIS array !

namespace godot {

class LOOKUPBLOCK : public Node {
	GDCLASS(LOOKUPBLOCK, Node)

private:
	
protected:
	static void _bind_methods();

public:
	
	Array allBlocks;

	BLOCK *penis[63]; // must be largest id + 1

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

	Dictionary runOnTick(int x, int y, PLANETDATA *planet, int dir, int blockID);
	Dictionary runOnBreak(int x, int y, PLANETDATA *planet, int dir, int blockID);

};

}

#endif