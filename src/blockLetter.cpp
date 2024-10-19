#include "blockLetter.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKLETTER::_bind_methods() {
}

BLOCKLETTER::BLOCKLETTER() {

    setTexture("res://items/blocks/building/letters.png");

    itemToDrop = 62;
    rotateTextureToGravity = true;
    soundMaterial = 2;
    multitile = true;
    lightMultiplier = 0.8;

}


BLOCKLETTER::~BLOCKLETTER() {
}

