#include "blockMossVine.h"
#include <godot_cpp/core/class_db.hpp>

#include <godot_cpp/variant/utility_functions.hpp>

#include "lookupBlock.h"

using namespace godot;

void BLOCKMOSSVINE::_bind_methods() {
}

BLOCKMOSSVINE::BLOCKMOSSVINE() {

    setTexture("res://items/blocks/foliage/moss/vine.png");

    breakTime = 0.1;
    hasCollision = false;
    rotateTextureToGravity = true;
    connectTexturesToMe = false;
    isTransparent = true;
    multitile = true;
    soundMaterial = 5;

}


BLOCKMOSSVINE::~BLOCKMOSSVINE() {
}

Dictionary BLOCKMOSSVINE::onTick(int x, int y, PLANETDATA *planet, int dir){
    Dictionary changes = {};


    int timeAlive = planet->getGlobalTick() - planet->getTimeData(x,y);

    Vector2i BREAK = Vector2i(Vector2(0,-1).rotated(acos(0.0)*dir));
    int whatsBelowMe = planet->getTileData(BREAK.x + x,BREAK.y + y);
    if( !lookup->hasCollision(whatsBelowMe) && whatsBelowMe != 75 ){
        changes[Vector2i(x,y)] = -1;
        return changes;

    }
    Vector2i below = Vector2i(Vector2(0,1).rotated(acos(0.0)*dir));
    int info = planet->getInfoData(x,y);
    if (info == 1){ // if loose vine end
        if (timeAlive>1000){
            if( planet->getTileData(below.x + x,below.y + y) < 2 ){
                changes[Vector2i(below.x + x,below.y + y)] = 75;
                planet->setInfoData(x,y,0);
                planet->setInfoData(below.x + x,below.y + y,1);

                if (std::rand() % 4 == 0){
                    planet->setInfoData(below.x + x,below.y + y,0); // 1 in 4 chance to end vine
                }

                planet->setTimeData(below.x + x,below.y + y, planet->getGlobalTick() - ( (timeAlive-1000)/1000)*1000 );
            }else{planet->setTimeData(x,y,planet->getGlobalTick());}
        }
    }

    return changes;
}