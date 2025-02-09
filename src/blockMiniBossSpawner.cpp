#include "blockMiniBossSpawner.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKMINIBOSSSPAWNER::_bind_methods() {
}

BLOCKMINIBOSSSPAWNER::BLOCKMINIBOSSSPAWNER() {

    setTexture("res://items/blocks/pillars/miniboss.png");

    itemToDrop = 147;
    rotateTextureToGravity = true;

    connectTexturesToMe = false;
    hasCollision = false;
    isTransparent = true;

    miningLevel = 99;

}


BLOCKMINIBOSSSPAWNER::~BLOCKMINIBOSSSPAWNER() {
}