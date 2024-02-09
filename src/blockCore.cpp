#include "blockCore.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKCORE::_bind_methods() {
}

BLOCKCORE::BLOCKCORE() {

    ResourceLoader rl;
    texture = rl.load("res://block_resources/block_textures/core.png");

}


BLOCKCORE::~BLOCKCORE() {
}

