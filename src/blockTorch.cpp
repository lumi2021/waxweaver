#include "blockTorch.h"
#include <godot_cpp/core/class_db.hpp>

#include <godot_cpp/variant/utility_functions.hpp>

#include "lookupBlock.h"

using namespace godot;

void BLOCKTORCH::_bind_methods() {
}

BLOCKTORCH::BLOCKTORCH() {

    setTexture("res://block_resources/block_textures/torch.png");

    breakTime = 0.0;

    breakParticleID = 13;

    hasCollision = false;

    lightMultiplier = 1.0;
    lightEmmission = 2.8;

    rotateTextureToGravity = true;

    connectTexturesToMe = false;

    itemToDrop = 15;

    animated = true;
    multitile = true;

}


BLOCKTORCH::~BLOCKTORCH() {
}

