#include "blockWool.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKWOOL::_bind_methods() {
}

BLOCKWOOL::BLOCKWOOL() {

    setTexture("res://items/blocks/building/colors/wool.png");

    itemToDrop = 53;
    multitile = true;
    lightMultiplier = 0.9;
    rotateTextureToGravity = true;
    soundMaterial = 4;

}


BLOCKWOOL::~BLOCKWOOL() {
}

