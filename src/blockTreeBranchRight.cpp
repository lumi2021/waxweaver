#include "blockTreeBranchRight.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKTREEBRANCHRIGHT::_bind_methods() {
}

BLOCKTREEBRANCHRIGHT::BLOCKTREEBRANCHRIGHT() {

    setTexture("res://items/blocks/foliage/trees/forestTree/leavesBranchRight.png");

    breakTime = 0.5;

    breakParticleID = 8;

    hasCollision = false;

    lightMultiplier = 0.8;
    
    rotateTextureToGravity = true;

    connectTexturesToMe = false;

    isTransparent = true;

    itemToDrop = 13;

    soundMaterial = 2;

}


BLOCKTREEBRANCHRIGHT::~BLOCKTREEBRANCHRIGHT() {
}

