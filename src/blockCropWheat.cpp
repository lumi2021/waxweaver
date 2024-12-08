#include "blockCropWheat.h"
#include <godot_cpp/core/class_db.hpp>

#include <godot_cpp/variant/utility_functions.hpp>

#include "lookupBlock.h"

using namespace godot;

void BLOCKCROPWHEAT::_bind_methods() {
}

BLOCKCROPWHEAT::BLOCKCROPWHEAT() {

    setTexture("res://items/blocks/foliage/crops/wheat.png");

    breakTime = 0.0;

    breakParticleID = 12;

    hasCollision = false;

    lightMultiplier = 0.98;

    rotateTextureToGravity = true;

    connectTexturesToMe = false;

    itemToDrop = 83;

    isTransparent = true;

    multitile = true;
    soundMaterial = 5;

}


BLOCKCROPWHEAT::~BLOCKCROPWHEAT() {
}

Dictionary BLOCKCROPWHEAT::onTick(int x, int y, PLANETDATA *planet, int dir){
    Dictionary changes = {};


    // break if not on wet soil
    Vector2i BREAK = Vector2i(Vector2(0,1).rotated(acos(0.0)*dir));
    int whatsBelowMe = planet->getTileData(BREAK.x + x,BREAK.y + y);
    if( whatsBelowMe != 35 ){ // if not on wet soil
        changes[Vector2i(x,y)] = -1;
        return changes;

    }

    int timeAlive = planet->getGlobalTick() - planet->getTimeData(x,y);
    int step = planet->getInfoData( x,y );

    if (step >= 2){
        return changes;
    }


    if ( timeAlive > 1000 ) { // aged long enough

        int wow = (timeAlive / 1000) - 1;

        if (wow >= 10){
            wow = 9;
        }

        if ( std::rand() % (10-wow) == 0 ){

            planet->setInfoData( x,y,step + 1 );
            changes[Vector2i(x,y)] = 83;
            planet->setTimeData(x,y,planet->getGlobalTick() );
            return changes;

        }

        planet->setTimeData(x,y,planet->getGlobalTick() );

    }







    return changes;
}