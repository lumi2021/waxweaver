#include "blockBarCopper.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKBARCOPPER::_bind_methods() {
}

BLOCKBARCOPPER::BLOCKBARCOPPER() {

    setTexture("res://items/material/bars/copperBlock.png");

    itemToDrop = 29;
    rotateTextureToGravity = true;
    multitile = true;

}


BLOCKBARCOPPER::~BLOCKBARCOPPER() {
}

Dictionary BLOCKBARCOPPER::onTick(int x, int y, PLANETDATA *planet, int dir){
    
    Dictionary changes = {};
    
    int time = planet->getGlobalTick();
    int oldTime = planet->getTimeData(x,y);

    int currentAge = planet->getInfoData(x,y);


    if (currentAge >= 3){
        return changes; // return if max age
    }

    if (time - oldTime < 100){
        return changes; // return if not time for update
    }

    if (time - oldTime > 120000){
        planet->setInfoData(x,y,3);
        planet->setTimeData(x,y,time);
        changes[Vector2i(x,y)] = 29;
        return changes; // force age if enough time has passed while unloaded
    }

    if (std::rand() % 30 != 0){
        planet->setTimeData(x,y,time);
        return changes; // return if random roll fails
    }

    // random roll succeeded, continue...

    float ageTotal = 0.0;
    
    for(int i = 0; i < 4; i++){

        Vector2i dir = Vector2i( Vector2(1,0).rotated( acos(0.0) * i ) ) + Vector2i(x,y);
        int dType = planet->getTileData(dir.x,dir.y);

        if (dType == 29){ // is copper block
            int dAge = planet->getInfoData(dir.x,dir.y);
            ageTotal = ageTotal + dAge;
        }else{
            ageTotal = ageTotal + 3.0;
        }


    }


    if (currentAge < ageTotal / 4.0){ // average of surrounding ages
        if (std::rand() % 3 == 0){
            planet->setInfoData(x,y,currentAge + 1);
            planet->setTimeData(x,y,time);
            changes[Vector2i(x,y)] = 29;
        }
    }else{
        if (std::rand() % 50 == 0){
            planet->setInfoData(x,y,currentAge + 1);
            planet->setTimeData(x,y,time);
            changes[Vector2i(x,y)] = 29;
        } 
    }





    return changes;

}