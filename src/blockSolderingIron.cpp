#include "blockSolderingIron.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKSOLDERINGIRON::_bind_methods() {
}

BLOCKSOLDERINGIRON::BLOCKSOLDERINGIRON() {

    setTexture("res://items/blocks/furniture/stations/solderingIron.png");

    itemToDrop = 94;
    rotateTextureToGravity = true;
    hasCollision = false;
    isTransparent = true;
    connectTexturesToMe = false;
    breakTime = 1.0;
    soundMaterial = 0;
}


BLOCKSOLDERINGIRON::~BLOCKSOLDERINGIRON() {
}

