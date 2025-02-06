#include "blockPinkWood.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKPINKWOOD::_bind_methods() {
}

BLOCKPINKWOOD::BLOCKPINKWOOD() {

    setTexture("res://items/blocks/building/pinkWood.png");

    itemToDrop = 136;
    rotateTextureToGravity = true;
    soundMaterial = 2;

}


BLOCKPINKWOOD::~BLOCKPINKWOOD() {
}

