#include "blockTrapdoorClosed.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKTRAPDOORCLOSED::_bind_methods() {
}

BLOCKTRAPDOORCLOSED::BLOCKTRAPDOORCLOSED() {

    setTexture("res://items/blocks/furniture/trapdoors/allTrapdoorsClosed.png");

    itemToDrop = 47;
    rotateTextureToGravity = true;
    multitile = true;
    isTransparent = true;
    connectTexturesToMe = false;
    soundMaterial = 2;
}


BLOCKTRAPDOORCLOSED::~BLOCKTRAPDOORCLOSED() {
}