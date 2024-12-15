#include "blockLever.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKLEVER::_bind_methods() {
}

BLOCKLEVER::BLOCKLEVER() {

    setTexture("res://items/electrical/input/lever.png");

    itemToDrop = 97;
    rotateTextureToGravity = false;
    hasCollision = false;
    isTransparent = true;
    connectTexturesToMe = false;
    multitile = true;
    breakTime = 0.2;
    soundMaterial = 2;
}


BLOCKLEVER::~BLOCKLEVER() {
}

