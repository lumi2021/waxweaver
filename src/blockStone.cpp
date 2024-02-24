#include "blockStone.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKSTONE::_bind_methods() {
}

BLOCKSTONE::BLOCKSTONE() {

    setTexture("res://block_resources/block_textures/stone.png");


    lightMultiplier = 0.8;
}


BLOCKSTONE::~BLOCKSTONE() {
}

