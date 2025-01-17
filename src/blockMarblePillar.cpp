#include "blockMarblePillar.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKMARBLEPILLAR::_bind_methods() {
}

BLOCKMARBLEPILLAR::BLOCKMARBLEPILLAR() {

    setTexture("res://items/blocks/building/marblePillar.png");

    itemToDrop = 116;
    rotateTextureToGravity = true;

    connectedTexture = true;
    connectTexturesToMe = false;
    connectToSelfOnly = true;
    hasCollision = false;
    isTransparent = true;


}


BLOCKMARBLEPILLAR::~BLOCKMARBLEPILLAR() {
}