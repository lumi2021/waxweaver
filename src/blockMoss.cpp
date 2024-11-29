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
    lightEmmission = 0.0;
}


BLOCKMOSS::~BLOCKMOSS() {
}

Dictionary BLOCKMOSS::onTick(int x, int y, PLANETDATA *planet, int dir){

    Dictionary changes = {};
    int timeAlive = planet->getGlobalTick() - planet->getTimeData(x,y);
    
    
    if (timeAlive < 1000){
        return changes; // cancel if younger than 1000 ticks
    }

    Vector2i below = Vector2i(Vector2(0,1).rotated(acos(0.0)*dir));
    Vector2i above = Vector2i(Vector2(0,-1).rotated(acos(0.0)*dir));
    if( planet->getTileData(below.x + x,below.y + y) < 2 ){ // scan for air below to determine if we should grow a vine
        changes[Vector2i(below.x + x,below.y + y)] = 75;
        planet->setTimeData(below.x + x,below.y + y, planet->getGlobalTick() - timeAlive );
        planet->setInfoData(below.x + x,below.y + y,1);
        planet->setTimeData(x,y,planet->getGlobalTick());
        return changes;

    }else if(planet->getTileData(above.x + x,above.y + y) < 2){ // scans for air above
        if (timeAlive > 9000){ // must be older than 10 irl minutes
            
            // randomly decide here to grow other plants, for now orb only
            
            int itemToGrow = 77;
            int r = std::rand() % 20;

            if (r == 0){
                itemToGrow = 76;
            }

            if (r >= 16){
                planet->setTimeData(x,y,planet->getGlobalTick());
                return changes;
            }


            changes[Vector2i(above.x + x,above.y + y)] = itemToGrow;
            planet->setTimeData(above.x + x,above.y + y, planet->getGlobalTick() - timeAlive + 9000 );
            planet->setTimeData(x,y,planet->getGlobalTick());

        }
    }else{
        planet->setTimeData(x,y,planet->getGlobalTick());
    }



	return changes;

}