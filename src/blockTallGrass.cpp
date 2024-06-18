#include "blockTallGrass.h"
#include <godot_cpp/core/class_db.hpp>

#include <godot_cpp/variant/utility_functions.hpp>

#include "lookupBlock.h"

using namespace godot;

void BLOCKTALLGRASS::_bind_methods() {
}

BLOCKTALLGRASS::BLOCKTALLGRASS() {

    setTexture("res://items/blocks/foliage/tallGrass.png");

    breakTime = 0.0;

    breakParticleID = 8;

    hasCollision = false;

    lightMultiplier = 1.0;

    rotateTextureToGravity = true;

    connectTexturesToMe = false;

    //itemToDrop = 7;

    animated = true;

}


BLOCKTALLGRASS::~BLOCKTALLGRASS() {
}

Dictionary BLOCKTALLGRASS::onTick(int x, int y, PLANETDATA *planet, int dir){
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