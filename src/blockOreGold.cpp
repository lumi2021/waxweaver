#include "blockOreGold.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKOREGOLD::_bind_methods() {
}

BLOCKOREGOLD::BLOCKOREGOLD() {

    setTexture("res://items/blocks/ores/goldOre.png");

    itemToDrop = 24;
    rotateTextureToGravity = true;
    breakTime = 0.8;

}


BLOCKOREGOLD::~BLOCKOREGOLD() {
}