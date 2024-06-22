#include "blockGlass.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKGLASS::_bind_methods() {
}

BLOCKGLASS::BLOCKGLASS() {

    setTexture("res://items/blocks/building/glass.png");

    itemToDrop = 21;
    rotateTextureToGravity = true;
    connectedTexture = true;

}


BLOCKGLASS::~BLOCKGLASS() {
}

