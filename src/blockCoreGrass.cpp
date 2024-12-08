#include "blockCoreGrass.h"
#include <godot_cpp/core/class_db.hpp>

#include <godot_cpp/variant/utility_functions.hpp>

#include "lookupBlock.h"

using namespace godot;

void BLOCKCOREGRASS::_bind_methods() {
}

BLOCKCOREGRASS::BLOCKCOREGRASS() {

    setTexture("res://items/blocks/foliage/core/foliage.png");

    breakTime = 0.0;
    breakParticleID = 5;
    hasCollision = false;
    rotateTextureToGravity = true;
    connectTexturesToMe = false;
    multitile = true;
    isTransparent = true;
    soundMaterial = 5;

}


BLOCKCOREGRASS::~BLOCKCOREGRASS() {
}

Dictionary BLOCKCOREGRASS::onTick(int x, int y, PLANETDATA *planet, int dir){
    Dictionary changes = {};


    int timeAlive = planet->getGlobalTick() - planet->getTimeData(x,y);

    Vector2i BREAK = Vector2i(Vector2(0,1).rotated(acos(0.0)*dir));
    int whatsBelowMe = planet->getTileData(BREAK.x + x,BREAK.y + y);
    if( !lookup->hasCollision(whatsBelowMe) ){
        changes[Vector2i(x,y)] = -1;
        return changes;

    }


    return changes;
}