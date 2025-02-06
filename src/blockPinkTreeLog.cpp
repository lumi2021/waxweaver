#include "blockPinkTreeLog.h"
#include "lookupBlock.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKPINKTREELOG::_bind_methods() {
}

BLOCKPINKTREELOG::BLOCKPINKTREELOG() {

    setTexture("res://items/blocks/foliage/trees/pinkTree/stem.png");

    breakTime = 1.0;

    breakParticleID = 136;

    hasCollision = false;

    lightMultiplier = 0.8;

    rotateTextureToGravity = true;

    connectTexturesToMe = false;

    itemToDrop = 136;

    soundMaterial = 2;

    isTransparent = true;
    multitile = true;

}


BLOCKPINKTREELOG::~BLOCKPINKTREELOG() {
}


Dictionary BLOCKPINKTREELOG::onTick(int x, int y, PLANETDATA *planet, int dir){
    
    Dictionary changes = {};

    Vector2i BREAK = Vector2i(Vector2(0,1).rotated(acos(0.0)*dir));
    int tileBelow = planet->getTileData(BREAK.x + x,BREAK.y + y);

    if ( !lookup->hasCollision(tileBelow) && tileBelow != 132){
        changes[Vector2i(x,y)] = -1;

    }

    return changes;

}