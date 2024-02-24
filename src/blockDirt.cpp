#include "blockDirt.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKDIRT::_bind_methods() {
}

BLOCKDIRT::BLOCKDIRT() {

    setTexture("res://block_resources/block_textures/dirt.png");

    itemToDrop = 0;
    rotateTextureToGravity = true;

}


BLOCKDIRT::~BLOCKDIRT() {
}

