#include "blockOreGold.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKOREGOLD::_bind_methods() {
}

BLOCKOREGOLD::BLOCKOREGOLD() {

    setTexture("res://items/blocks/ores/goldOre.png");

    itemToDrop = 24;
    rotateTextureToGravity = true;
    breakTime = 1.0;
    miningLevel = 1;

}


BLOCKOREGOLD::~BLOCKOREGOLD() {
}

Dictionary BLOCKOREGOLD::onTick(int x, int y, PLANETDATA *planet, int dir){

    Dictionary changes = {};

    if(planet->getGlobalTick() % 30 != 0){
        return changes;
    }

    if(abs(planet->getLightData(x,y)) > 0.1){
        if(std::rand() % 10 == 0){
            changes[Vector2i(x,y)] = "sparkle";
        }

    }

    return changes;

}