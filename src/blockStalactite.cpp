#include "blockStalactite.h"
#include <godot_cpp/core/class_db.hpp>

#include <godot_cpp/variant/utility_functions.hpp>

#include "lookupBlock.h"

using namespace godot;

void BLOCKSTALACTITE::_bind_methods() {
}

BLOCKSTALACTITE::BLOCKSTALACTITE() {

    setTexture("res://items/blocks/foliage/rockFoliage/stalactite.png");

    breakTime = 1.0;

    breakParticleID = 2;

    hasCollision = false;

    lightMultiplier = 0.97;

    rotateTextureToGravity = true;

    connectTexturesToMe = false;

    itemToDrop = 2;

    isTransparent = true;

    multitile = true;

}


BLOCKSTALACTITE::~BLOCKSTALACTITE() {
}

Dictionary BLOCKSTALACTITE::onTick(int x, int y, PLANETDATA *planet, int dir){
    Dictionary changes = {};


    int timeAlive = planet->getGlobalTick() - planet->getTimeData(x,y);

    Vector2i BREAK = Vector2i(Vector2(0,-1).rotated(acos(0.0)*dir));
    int whatsBelowMe = planet->getTileData(BREAK.x + x,BREAK.y + y);
    if( !lookup->hasCollision(whatsBelowMe) ){
        changes[Vector2i(x,y)] = -1;
        return changes;

    }


    return changes;
}