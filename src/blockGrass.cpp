#include "blockGrass.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKGRASS::_bind_methods() {
}

BLOCKGRASS::BLOCKGRASS() {

    ResourceLoader rl;
    texture = rl.load("res://block_resources/block_textures/grass.png");

    connectedTexture = true;

}


BLOCKGRASS::~BLOCKGRASS() {
}

