#include "blockLeavesStaticPine.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKLEAVESSTATICPINE::_bind_methods() {
}

BLOCKLEAVESSTATICPINE::BLOCKLEAVESSTATICPINE() {

    setTexture("res://items/blocks/foliage/trees/pineTree/pineleaves.png");

    breakTime = 0.5;

    breakParticleID = 12;

    hasCollision = false;

    lightMultiplier = 0.8;

    rotateTextureToGravity = true;

    connectTexturesToMe = true;
    connectedTexture = true;

    itemToDrop = 165;
    isTransparent = true;

    soundMaterial = 5;

}


BLOCKLEAVESSTATICPINE::~BLOCKLEAVESSTATICPINE() {
}

Dictionary BLOCKLEAVESSTATICPINE::onTick(int x, int y, PLANETDATA *planet, int dir){
    Dictionary changes = {};


    if(std::rand()%1000==0){
        changes[Vector2i(x,y)] = "leaf";
        return changes;
    }

    return changes;

}