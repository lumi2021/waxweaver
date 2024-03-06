#include "blockTreeBranchRight.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKTREEBRANCHRIGHT::_bind_methods() {
}

BLOCKTREEBRANCHRIGHT::BLOCKTREEBRANCHRIGHT() {

    setTexture("res://block_resources/block_textures/leavesBranchRight.png");

    breakTime = 0.5;

    breakParticleID = 8;

    hasCollision = false;

    lightMultiplier = 1.0;
    
    rotateTextureToGravity = true;

    connectTexturesToMe = false;

}


BLOCKTREEBRANCHRIGHT::~BLOCKTREEBRANCHRIGHT() {
}

