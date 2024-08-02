#include "blockBarIron.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKBARIRON::_bind_methods() {
}

BLOCKBARIRON::BLOCKBARIRON() {

    setTexture("res://items/material/bars/ironBlock.png");

    itemToDrop = 31;
    rotateTextureToGravity = true;

}


BLOCKBARIRON::~BLOCKBARIRON() {
}