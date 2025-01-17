#include "blockOreIron.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKOREIRON::_bind_methods() {
}

BLOCKOREIRON::BLOCKOREIRON() {

    setTexture("res://items/blocks/ores/ironOre.png");

    itemToDrop = 27;
    rotateTextureToGravity = true;
    breakTime = 1.2;
    miningLevel = 2;

}


BLOCKOREIRON::~BLOCKOREIRON() {
}

Dictionary BLOCKOREIRON::onTick(int x, int y, PLANETDATA *planet, int dir){

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