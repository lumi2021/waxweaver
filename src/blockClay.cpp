#include "blockClay.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKCLAY::_bind_methods() {
}

BLOCKCLAY::BLOCKCLAY() {

    setTexture("res://items/blocks/natural/clay.png");

    itemToDrop = 88;
    rotateTextureToGravity = true;
    soundMaterial = 1;
}


BLOCKCLAY::~BLOCKCLAY() {
}

