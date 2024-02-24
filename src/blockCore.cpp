#include "blockCore.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKCORE::_bind_methods() {
}

BLOCKCORE::BLOCKCORE() {

    setTexture("res://block_resources/block_textures/core.png");

    breakTime = 999999.0;

}


BLOCKCORE::~BLOCKCORE() {
}

