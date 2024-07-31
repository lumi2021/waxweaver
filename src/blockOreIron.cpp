#include "blockOreIron.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKOREIRON::_bind_methods() {
}

BLOCKOREIRON::BLOCKOREIRON() {

    setTexture("res://items/blocks/ores/ironOre.png");

    itemToDrop = 27;
    rotateTextureToGravity = true;
    breakTime = 1.2;

}


BLOCKOREIRON::~BLOCKOREIRON() {
}