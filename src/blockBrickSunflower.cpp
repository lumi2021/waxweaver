#include "blockBrickSunflower.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKBRICKSUNFLOWER::_bind_methods() {
}

BLOCKBRICKSUNFLOWER::BLOCKBRICKSUNFLOWER() {

    setTexture("res://items/blocks/building/sunflowerBrick.png");

    itemToDrop = 150;
    rotateTextureToGravity = true;
    breakTime = 1.0;
}


BLOCKBRICKSUNFLOWER::~BLOCKBRICKSUNFLOWER() {
}

