#include "blockTreeBranchLeaf.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKTREEBRANCHLEAF::_bind_methods() {
}

BLOCKTREEBRANCHLEAF::BLOCKTREEBRANCHLEAF() {

    setTexture("res://items/blocks/foliage/trees/forestTree/leavesBranch.png");

    breakTime = 1.0;

    breakParticleID = -1;

    hasCollision = false;

    lightMultiplier = 0.8;

    rotateTextureToGravity = true;

    connectTexturesToMe = true;

}


BLOCKTREEBRANCHLEAF::~BLOCKTREEBRANCHLEAF() {
}

Dictionary BLOCKTREEBRANCHLEAF::onBreak(int x, int y, PLANETDATA *planet, int dir){

    Dictionary changes = {};

   
    return changes;

}