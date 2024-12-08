#include "blockIce.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKICE::_bind_methods() {
}

BLOCKICE::BLOCKICE() {

    setTexture("res://items/blocks/natural/ice.png");

    itemToDrop = 86;
    rotateTextureToGravity = true;
    natural = true;
    soundMaterial = 6;
}


BLOCKICE::~BLOCKICE() {
}