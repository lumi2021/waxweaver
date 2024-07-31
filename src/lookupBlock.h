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

// adding a new block? make sure you increment the PENIS array !

namespace godot {

class LOOKUPBLOCK : public Node {
	GDCLASS(LOOKUPBLOCK, Node)

private:
	
protected:
	static void _bind_methods();

public:
	
	Array allBlocks;

	BLOCK *penis[27]; // must be largest id + 1

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

	Dictionary runOnTick(int x, int y, PLANETDATA *planet, int dir, int blockID);
	Dictionary runOnBreak(int x, int y, PLANETDATA *planet, int dir, int blockID);

};

}

#endif