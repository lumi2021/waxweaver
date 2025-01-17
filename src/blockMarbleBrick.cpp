#include "blockMarbleBrick.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKMARBLEBRICK::_bind_methods() {
}

BLOCKMARBLEBRICK::BLOCKMARBLEBRICK() {

    setTexture("res://items/blocks/building/marbleBrick.png");

    itemToDrop = 115;
    rotateTextureToGravity = true;

}


BLOCKMARBLEBRICK::~BLOCKMARBLEBRICK() {
}