#include "blockBarGold.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKBARGOLD::_bind_methods() {
}

BLOCKBARGOLD::BLOCKBARGOLD() {

    setTexture("res://items/material/bars/goldBlock.png");

    itemToDrop = 30;
    rotateTextureToGravity = true;

}


BLOCKBARGOLD::~BLOCKBARGOLD() {
}