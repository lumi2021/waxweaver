#include "blockStone.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKSTONE::_bind_methods() {
}

BLOCKSTONE::BLOCKSTONE() {

    setTexture("res://items/blocks/natural/stone.png");

    itemToDrop = 2;
    rotateTextureToGravity = true;

}


BLOCKSTONE::~BLOCKSTONE() {
}