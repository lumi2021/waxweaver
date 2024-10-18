#include "blockSunflowerLeaf.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKSUNFLOWERLEAF::_bind_methods() {
}

BLOCKSUNFLOWERLEAF::BLOCKSUNFLOWERLEAF() {

    setTexture("res://items/blocks/foliage/trees/sunflowerTree/leaves.png");

    breakTime = 0.4;

    breakParticleID = -1;

    hasCollision = false;

    lightMultiplier = 0.8;

    rotateTextureToGravity = true;

    connectTexturesToMe = false;

    itemToDrop = 60;

    soundMaterial = 2;

    multitile = true;

    isTransparent = true;

}


BLOCKSUNFLOWERLEAF::~BLOCKSUNFLOWERLEAF() {
}