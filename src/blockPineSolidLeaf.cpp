#include "blockPineSolidLeaf.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKPINESOLIDLEAF::_bind_methods() {
}

BLOCKPINESOLIDLEAF::BLOCKPINESOLIDLEAF() {

    setTexture("res://items/blocks/foliage/trees/pineTree/leaflogpine.png");

    breakTime = 1.0;

    breakParticleID = -1;

    hasCollision = false;

    lightMultiplier = 0.8;

    rotateTextureToGravity = true;

    connectTexturesToMe = true;

    itemToDrop = 13;

    soundMaterial = 2;

}


BLOCKPINESOLIDLEAF::~BLOCKPINESOLIDLEAF() {
}

Dictionary BLOCKPINESOLIDLEAF::onBreak(int x, int y, PLANETDATA *planet, int dir){

    Dictionary changes = {};

   
    return changes;

}