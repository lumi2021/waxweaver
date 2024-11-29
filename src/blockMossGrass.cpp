#include "blockMossGrass.h"
#include <godot_cpp/core/class_db.hpp>

#include <godot_cpp/variant/utility_functions.hpp>

#include "lookupBlock.h"

using namespace godot;

void BLOCKMOSSGRASS::_bind_methods() {
}

BLOCKMOSSGRASS::BLOCKMOSSGRASS() {

    setTexture("res://items/blocks/foliage/moss/mossGrass.png");

    breakTime = 0.0;
    hasCollision = false;

    lightMultiplier = 1.0;

    rotateTextureToGravity = true;

    connectTexturesToMe = false;

    //itemToDrop = 7;

    animated = true;

    isTransparent = true;
    soundMaterial = 5;

}


BLOCKMOSSGRASS::~BLOCKMOSSGRASS() {
}

Dictionary BLOCKMOSSGRASS::onTick(int x, int y, PLANETDATA *planet, int dir){
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