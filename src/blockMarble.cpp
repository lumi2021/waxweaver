#include "blockMarble.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKMARBLE::_bind_methods() {
}

BLOCKMARBLE::BLOCKMARBLE() {

    setTexture("res://items/blocks/natural/marble.png");

    itemToDrop = 114;
    rotateTextureToGravity = true;
    natural = true;
}


BLOCKMARBLE::~BLOCKMARBLE() {
}