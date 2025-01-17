#include "blockChain.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKCHAIN::_bind_methods() {
}

BLOCKCHAIN::BLOCKCHAIN() {

    setTexture("res://items/blocks/furniture/other/chain.png");

    itemToDrop = 124;
    rotateTextureToGravity = true;

    connectTexturesToMe = false;
    hasCollision = false;
    isTransparent = true;
    breakTime = 0.25;
    breakParticleID = 5;


}


BLOCKCHAIN::~BLOCKCHAIN() {
}