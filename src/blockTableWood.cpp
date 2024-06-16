#include "blockTableWood.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKTABLEWOOD::_bind_methods() {
}

BLOCKTABLEWOOD::BLOCKTABLEWOOD() {

    setTexture("res://block_resources/multitile_textures/testTable.png");

    multitile = true;
    rotateTextureToGravity = true;
    hasCollision = false;

}


BLOCKTABLEWOOD::~BLOCKTABLEWOOD() {
}