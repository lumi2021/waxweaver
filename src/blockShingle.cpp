#include "blockShingle.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKSHINGLE::_bind_methods() {
}

BLOCKSHINGLE::BLOCKSHINGLE() {

    setTexture("res://items/blocks/building/shingle/shingles.png");

    itemToDrop = 142;
    multitile = true;
    lightMultiplier = 0.9;
    rotateTextureToGravity = true;
    soundMaterial = 2;
    backgroundColorImmune = true;

}


BLOCKSHINGLE::~BLOCKSHINGLE() {
}

