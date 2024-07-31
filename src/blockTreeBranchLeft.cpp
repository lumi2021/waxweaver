#include "blockTreeBranchLeft.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKTREEBRANCHLEFT::_bind_methods() {
}

BLOCKTREEBRANCHLEFT::BLOCKTREEBRANCHLEFT() {

    setTexture("res://block_resources/block_textures/leavesBranchLeft.png");

    breakTime = 0.5;

    breakParticleID = 8;

    hasCollision = false;

    lightMultiplier = 0.99;

    rotateTextureToGravity = true;

    connectTexturesToMe = false;

}


BLOCKTREEBRANCHLEFT::~BLOCKTREEBRANCHLEFT() {
}

