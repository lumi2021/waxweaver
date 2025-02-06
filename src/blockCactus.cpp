#include "blockCactus.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKCACTUS::_bind_methods() {
}

BLOCKCACTUS::BLOCKCACTUS() {

    setTexture("res://items/blocks/foliage/trees/cactus/cactus.png");

    rotateTextureToGravity = true;
    hasCollision = false;
    multitile = true;
    isTransparent = true;
    soundMaterial = 5;
    connectTexturesToMe = false;
    itemToDrop = 87;
}


BLOCKCACTUS::~BLOCKCACTUS() {
}

Dictionary BLOCKCACTUS::onTick(int x, int y, PLANETDATA *planet, int dir){

    Dictionary changes = {};
    
    Vector2i below = Vector2i(Vector2(0,1).rotated(acos(0.0)*dir));
    if (planet->getTileData(x+below.x,y+below.y) != 14 && planet->getTileData(x+below.x,y+below.y) != 87 ){ // check if block below isnt sand or cactus
        changes[ Vector2i(x,y) ] = -1;
        return changes;
    }

    int stage = planet->getInfoData(x,y);
    if( stage == 1){
        Vector2i above = Vector2i(Vector2(0,-1).rotated(acos(0.0)*dir));
        if (planet->getTileData(x+above.x,y+above.y) != 87){ // set cactus to knub if top piece is broken
            planet->setInfoData(x,y,2);
            planet->setTimeData(x,y, planet->getGlobalTick() );
        }
        return changes;
    }
    if( stage >= 3){return changes;}

    Vector2i above = Vector2i(Vector2(0,-1).rotated(acos(0.0)*dir));
    if (planet->getTileData(x+above.x,y+above.y) > 1){ // check if block above isnt filled, cancel so we don't grow into existing blocks
        return changes;
    }
    
    int timeAlive = planet->getGlobalTick() - planet->getTimeData(x,y);
    if ( timeAlive > 4500 ){
        planet->setTimeData(x,y, planet->getGlobalTick() );
        planet->setTimeData(x+above.x,y+above.y, planet->getGlobalTick() - (timeAlive - 4500) );
        
        changes[ Vector2i(x,y) ] = 87;
        changes[ Vector2i(x+above.x,y+above.y) ] = 87;
        
        planet->setInfoData(x,y,1);
        planet->setInfoData(x+above.x,y+above.y,2);
        if (std::rand() % 4 == 0){
            planet->setInfoData(x+above.x,y+above.y,3); // 25 percent chance to end growth
            if(std::rand() % 2 == 0){ planet->setInfoData(x+above.x,y+above.y,4); } // planet flower chance
        }


    }





	return changes;

}