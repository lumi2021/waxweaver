#include "blockFlowerPot.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKFLOWERPOT::_bind_methods() {
}

BLOCKFLOWERPOT::BLOCKFLOWERPOT() {

    setTexture("res://items/blocks/furniture/flowerpots/flowerpots.png");

    itemToDrop = 123;
    rotateTextureToGravity = true;

    connectTexturesToMe = false;
    hasCollision = false;
    isTransparent = true;
    multitile = true;


}


BLOCKFLOWERPOT::~BLOCKFLOWERPOT() {
}