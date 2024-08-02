#include "blockWood.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKWOOD::_bind_methods() {
}

BLOCKWOOD::BLOCKWOOD() {

    setTexture("res://items/blocks/building/woodPlank.png");

    itemToDrop = 13;
    rotateTextureToGravity = true;

}


BLOCKWOOD::~BLOCKWOOD() {
}

