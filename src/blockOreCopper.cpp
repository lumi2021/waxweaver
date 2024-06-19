#include "blockOreCopper.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKORECOPPER::_bind_methods() {
}

BLOCKORECOPPER::BLOCKORECOPPER() {

    setTexture("res://items/blocks/ores/copperOre.png");

    itemToDrop = 18;
    rotateTextureToGravity = true;
    breakTime = 0.8;

}


BLOCKORECOPPER::~BLOCKORECOPPER() {
}