#include "blockBlackstone.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKBLACKSTONE::_bind_methods() {
}

BLOCKBLACKSTONE::BLOCKBLACKSTONE() {

    setTexture("res://items/blocks/building/blackstoneBrick.png");

    itemToDrop = 141;
    rotateTextureToGravity = true;

}


BLOCKBLACKSTONE::~BLOCKBLACKSTONE() {
}