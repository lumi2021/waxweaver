#include "blockSandstoneBrick.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKSANDSTONEBRICK::_bind_methods() {
}

BLOCKSANDSTONEBRICK::BLOCKSANDSTONEBRICK() {

    setTexture("res://items/blocks/building/sandstoneBrick.png");

    itemToDrop = 137;
    rotateTextureToGravity = true;

}


BLOCKSANDSTONEBRICK::~BLOCKSANDSTONEBRICK() {
}