#include "blockSnow.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKSNOW::_bind_methods() {
}

BLOCKSNOW::BLOCKSNOW() {

    setTexture("res://items/blocks/natural/snow.png");

    itemToDrop = 85;
    rotateTextureToGravity = true;
    soundMaterial = 1;
    natural = true;
}


BLOCKSNOW::~BLOCKSNOW() {
}

