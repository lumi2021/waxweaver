#include "blockLeavesStatic.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKLEAVESSTATIC::_bind_methods() {
}

BLOCKLEAVESSTATIC::BLOCKLEAVESSTATIC() {

    setTexture("res://items/blocks/foliage/trees/forestTree/leaves.png");

    breakTime = 0.5;

    breakParticleID = 12;

    hasCollision = false;

    lightMultiplier = 0.8;

    rotateTextureToGravity = true;

    connectTexturesToMe = true;
    connectedTexture = true;

    itemToDrop = 164;
    isTransparent = true;

    soundMaterial = 5;

}


BLOCKLEAVESSTATIC::~BLOCKLEAVESSTATIC() {
}

Dictionary BLOCKLEAVESSTATIC::onTick(int x, int y, PLANETDATA *planet, int dir){
    Dictionary changes = {};


    if(std::rand()%1000==0){
        changes[Vector2i(x,y)] = "leaf";
        return changes;
    }

    return changes;

}