#include "blockLadder.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKLADDER::_bind_methods() {
}

BLOCKLADDER::BLOCKLADDER() {

    setTexture("res://items/blocks/furniture/other/ladder.png");

    itemToDrop = 25;
    rotateTextureToGravity = true;
    hasCollision = false;
    isTransparent = true;
    connectTexturesToMe = false;
    lightMultiplier = 1.0;
    breakTime = 0.2;
}


BLOCKLADDER::~BLOCKLADDER() {
}

