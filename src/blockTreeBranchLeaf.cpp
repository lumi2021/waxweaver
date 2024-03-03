#include "blockTreeBranchLeaf.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKTREEBRANCHLEAF::_bind_methods() {
}

BLOCKTREEBRANCHLEAF::BLOCKTREEBRANCHLEAF() {

    setTexture("res://block_resources/block_textures/leavesBranch.png");

    breakTime = 1.0;

    breakParticleID = -1;

    hasCollision = false;

    lightMultiplier = 1.0;

    rotateTextureToGravity = true;

    connectTexturesToMe = false;

}


BLOCKTREEBRANCHLEAF::~BLOCKTREEBRANCHLEAF() {
}

