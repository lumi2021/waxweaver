#include "blockRockDebris.h"
#include <godot_cpp/core/class_db.hpp>

#include <godot_cpp/variant/utility_functions.hpp>

#include "lookupBlock.h"

using namespace godot;

void BLOCKROCKDEBRIS::_bind_methods() {
}

BLOCKROCKDEBRIS::BLOCKROCKDEBRIS() {

    setTexture("res://items/blocks/foliage/rockFoliage/rockDebris.png");

    breakTime = 0.1;

    breakParticleID = 2;
    hasCollision = false;
    rotateTextureToGravity = true;
    connectTexturesToMe = false;
    itemToDrop = 2;
    isTransparent = true;
    multitile = true;

}


BLOCKROCKDEBRIS::~BLOCKROCKDEBRIS() {
}

Dictionary BLOCKROCKDEBRIS::onTick(int x, int y, PLANETDATA *planet, int dir){
    Dictionary changes = {};


    int timeAlive = planet->getGlobalTick() - planet->getTimeData(x,y);

    Vector2i BREAK = Vector2i(Vector2(0,1).rotated(acos(0.0)*dir));
    int whatsAboveMe = planet->getTileData(BREAK.x + x,BREAK.y + y);
    if( !lookup->hasCollision(whatsAboveMe) ){
        changes[Vector2i(x,y)] = -1;
        return changes;

    }
    if( whatsAboveMe == 74 ){ // is moss
        changes[Vector2i(x,y)] = 77; // replace with moss grass
        return changes;

    }


    return changes;
}