#include "blockSandstone.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKSANDSTONE::_bind_methods() {
}

BLOCKSANDSTONE::BLOCKSANDSTONE() {

    setTexture("res://items/blocks/natural/sandstone.png");

    itemToDrop = 84;
    rotateTextureToGravity = true;
    natural = true;
}


BLOCKSANDSTONE::~BLOCKSANDSTONE() {
}