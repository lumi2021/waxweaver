#include "blockAir.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKAIR::_bind_methods() {
}

BLOCKAIR::BLOCKAIR() {

    setTexture("res://block_resources/block_textures/air.png");

    connectTexturesToMe = false;

    hasCollision = false;

    lightMultiplier = 0.9;
    lightEmmission = 5.0;

    isTransparent = true;
}


BLOCKAIR::~BLOCKAIR() {
}

