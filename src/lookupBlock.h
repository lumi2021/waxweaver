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

namespace godot {

class LOOKUPBLOCK : public Node {
	GDCLASS(LOOKUPBLOCK, Node)

private:
	
protected:
	static void _bind_methods();

public:
	
	Array allBlocks;
	BLOCK *penis[7];

	LOOKUPBLOCK();
	~LOOKUPBLOCK();
    Dictionary getBlockData(int id);


	bool hasCollision(int id);
	bool isGravityRotate(int id);

	Ref<Image> getTextureImage(int id);

	bool isConnectedTexture(int id);
	bool isTextureConnector(int id);
	double getLightMultiplier(int id);
	double getLightEmmission(int id);

	Dictionary runOnTick(int x, int y, PLANETDATA *planet, int dir, int blockID);

};

}

#endif