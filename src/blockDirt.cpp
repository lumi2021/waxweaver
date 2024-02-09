#include "blockDirt.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKDIRT::_bind_methods() {
}

BLOCKDIRT::BLOCKDIRT() {

    ResourceLoader rl;
    texture = rl.load("res://block_resources/block_textures/dirt.png");

}


BLOCKDIRT::~BLOCKDIRT() {
}

