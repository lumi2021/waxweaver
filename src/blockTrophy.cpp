#include "blockTrophy.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKTROPHY::_bind_methods() {
}

BLOCKTROPHY::BLOCKTROPHY() {

    setTexture("res://items/blocks/furniture/trophies/trophies.png");

    itemToDrop = 130;
    multitile = true;
    rotateTextureToGravity = true;
    backgroundColorImmune = true;
    isTransparent = true;
    hasCollision = false;
    connectTexturesToMe = false;

}


BLOCKTROPHY::~BLOCKTROPHY() {
}

