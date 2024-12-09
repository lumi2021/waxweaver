#include "blockBrick.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKBRICK::_bind_methods() {
}

BLOCKBRICK::BLOCKBRICK() {

    setTexture("res://items/blocks/building/brick.png");

    itemToDrop = 89;
    rotateTextureToGravity = true;
    breakTime = 1.0;
}


BLOCKBRICK::~BLOCKBRICK() {
}

