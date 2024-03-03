#include "blockLeaves.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKLEAVES::_bind_methods() {
}

BLOCKLEAVES::BLOCKLEAVES() {

    setTexture("res://block_resources/block_textures/leaves.png");

    breakTime = 0.1;

    breakParticleID = -1;

    hasCollision = false;

    lightMultiplier = 1.0;

    rotateTextureToGravity = true;

    connectTexturesToMe = false;

}


BLOCKLEAVES::~BLOCKLEAVES() {
}

