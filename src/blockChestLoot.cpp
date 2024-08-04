#include "blockChestLoot.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKCHESTLOOT::_bind_methods() {
}

BLOCKCHESTLOOT::BLOCKCHESTLOOT() {

    setTexture("res://items/blocks/furniture/chests/chestsAll.png");

    itemToDrop = 6100;
    rotateTextureToGravity = true;
    isTransparent = true;
    multitile = true;
    hasCollision = false;
    lightMultiplier = 0.8;
    breakTime = 3.0;
    connectTexturesToMe = false;
    breakParticleID = 13;

}


BLOCKCHESTLOOT::~BLOCKCHESTLOOT() {
}

