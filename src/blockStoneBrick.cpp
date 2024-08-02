#include "blockStoneBrick.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKSTONEBRICK::_bind_methods() {
}

BLOCKSTONEBRICK::BLOCKSTONEBRICK() {

    setTexture("res://items/blocks/building/stoneBrick.png");

    itemToDrop = 32;
    rotateTextureToGravity = true;

}


BLOCKSTONEBRICK::~BLOCKSTONEBRICK() {
}