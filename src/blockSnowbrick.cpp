#include "blockSnowbrick.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKSNOWBRICK::_bind_methods() {
}

BLOCKSNOWBRICK::BLOCKSNOWBRICK() {

    setTexture("res://items/blocks/building/snowbrick.png");

    itemToDrop = 109;
    rotateTextureToGravity = true;

    soundMaterial = 1;

}


BLOCKSNOWBRICK::~BLOCKSNOWBRICK() {
}