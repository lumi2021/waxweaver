#include "blockSunflowerTop.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKSUNFLOWERTOP::_bind_methods() {
}

BLOCKSUNFLOWERTOP::BLOCKSUNFLOWERTOP() {

    setTexture("res://items/blocks/foliage/trees/sunflowerTree/flower.png");

    breakTime = 0.0;

    breakParticleID = -1;

    hasCollision = false;

    lightMultiplier = 0.8;

    rotateTextureToGravity = true;

    connectTexturesToMe = false;

    itemToDrop = 59;

    soundMaterial = 2;

    multitile = true;

    isTransparent = true;

}


BLOCKSUNFLOWERTOP::~BLOCKSUNFLOWERTOP() {
}