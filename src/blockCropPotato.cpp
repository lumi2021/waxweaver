#include "blockCropPotato.h"
#include <godot_cpp/core/class_db.hpp>

#include <godot_cpp/variant/utility_functions.hpp>

#include "lookupBlock.h"

using namespace godot;

void BLOCKCROPPOTATO::_bind_methods() {
}

BLOCKCROPPOTATO::BLOCKCROPPOTATO() {

    setTexture("res://items/blocks/foliage/crops/potato.png");

    breakTime = 0.0;

    breakParticleID = 12;

    hasCollision = false;

    lightMultiplier = 0.98;

    rotateTextureToGravity = true;

    connectTexturesToMe = false;

    itemToDrop = 37;

    isTransparent = true;

    multitile = true;

}


BLOCKCROPPOTATO::~BLOCKCROPPOTATO() {
}

Dictionary BLOCKCROPPOTATO::onTick(int x, int y, PLANETDATA *planet, int dir){
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

    if (step >= 4){
        return changes;
    }

    if ( timeAlive > 10000 ) { // age if unloaded

        planet->setInfoData( x,y,4 );
        changes[Vector2i(x,y)] = 37;
        return changes;
        
    }

    if ( timeAlive > 1800 ) { // aged long enough

        if ( std::rand() % 1000 == 0 ){

            planet->setInfoData( x,y,step + 1 );
            changes[Vector2i(x,y)] = 37;
            return changes;

        } else if ( timeAlive > 3000 ) {
            // assume that shit grew if its been long enough
            planet->setInfoData( x,y,step + 1 );
            changes[Vector2i(x,y)] = 37;
            return changes;

        }

    }







    return changes;
}