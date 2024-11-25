#include "blockMoss.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKMOSS::_bind_methods() {
}

BLOCKMOSS::BLOCKMOSS() {

    setTexture("res://items/blocks/natural/moss.png");

    itemToDrop = 74;
    rotateTextureToGravity = true;
    natural = true;
    connectedTexture = true;
    connectTexturesToMe = true;
    soundMaterial = 5;
    breakTime = 0.24;
    lightMultiplier = 0.5;
    lightEmmission = 0.12;
}


BLOCKMOSS::~BLOCKMOSS() {
}

Dictionary BLOCKMOSS::onTick(int x, int y, PLANETDATA *planet, int dir){

    Dictionary changes = {};
    int timeAlive = planet->getGlobalTick() - planet->getTimeData(x,y);
    
    Vector2i below = Vector2i(Vector2(0,1).rotated(acos(0.0)*dir));
    if (timeAlive < 1000){
        return changes;
    }

    if( planet->getTileData(below.x + x,below.y + y) < 2 ){ // scan for air below
        changes[Vector2i(below.x + x,below.y + y)] = 75;
        planet->setTimeData(below.x + x,below.y + y, planet->getGlobalTick() - timeAlive );
        planet->setInfoData(below.x + x,below.y + y,1);
        planet->setTimeData(x,y,planet->getGlobalTick());
        return changes;

    }else{
        planet->setTimeData(x,y,planet->getGlobalTick());
    }


	return changes;

}