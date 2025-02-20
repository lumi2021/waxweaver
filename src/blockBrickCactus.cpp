#include "blockBrickCactus.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKBRICKCACTUS::_bind_methods() {
}

BLOCKBRICKCACTUS::BLOCKBRICKCACTUS() {

    setTexture("res://items/blocks/building/cactusBrick.png");

    itemToDrop = 149;
    rotateTextureToGravity = true;
    breakTime = 1.0;
}


BLOCKBRICKCACTUS::~BLOCKBRICKCACTUS() {
}

