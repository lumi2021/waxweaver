#include "blockMossOrb.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKMOSSORB::_bind_methods() {
}

BLOCKMOSSORB::BLOCKMOSSORB() {

    setTexture("res://items/blocks/foliage/moss/orbPlant.png");

    itemToDrop = 76;
    rotateTextureToGravity = true;
    soundMaterial = 5;
    connectTexturesToMe = false;
    breakTime = 1.0;
    lightEmmission = 0.4;
    isTransparent = true;
    multitile = true;
    hasCollision = false;
}


BLOCKMOSSORB::~BLOCKMOSSORB() {
}

Dictionary BLOCKMOSSORB::onTick(int x, int y, PLANETDATA *planet, int dir){

    Dictionary changes = {};
    int info = planet->getInfoData(x,y);

    if (info == 0){ // 0 is the orignal baby plant, will grow after 9000 ticks of age
        int timeAlive = planet->getGlobalTick() - planet->getTimeData(x,y);
        if (timeAlive > 9000){
            Vector2i above = Vector2i(Vector2(0,-1).rotated(acos(0.0)*dir));

            if(planet->getTileData(above.x + x,above.y + y) > 1){
                return changes; // cancel if tile above isnt empty 
            }


            changes[Vector2i(above.x + x,above.y + y)] = 76; // sets block above to orb plant as well
            changes[Vector2i(x,y)] = 76; // sets self to orb so that chunks update properly

            planet->setInfoData(x,y,1);
            planet->setInfoData(above.x + x,above.y + y,2);
        }
    }
    
    Vector2i below = Vector2i(Vector2(0,1).rotated(acos(0.0)*dir));
    if(planet->getTileData(below.x + x,below.y + y) < 2){
        changes[Vector2i(x,y)] = -1; // force break if floating
    }


	return changes;

}

Dictionary BLOCKMOSSORB::onBreak(int x, int y, PLANETDATA *planet, int dir){
    Dictionary changes = {};
    int info = planet->getInfoData(x,y);
    if (info == 1){
        Vector2i above = Vector2i(Vector2(0,-1).rotated(acos(0.0)*dir));
        changes[Vector2i(above.x + x,above.y + y)] = 0;

    }else if( info == 2 ){
        Vector2i below = Vector2i(Vector2(0,1).rotated(acos(0.0)*dir));
        changes[Vector2i(below.x + x,below.y + y)] = 0;
    }
   
   
    return changes;
}