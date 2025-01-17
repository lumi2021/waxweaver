#include "blockOreCopper.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKORECOPPER::_bind_methods() {
}

BLOCKORECOPPER::BLOCKORECOPPER() {

    setTexture("res://items/blocks/ores/copperOre.png");

    itemToDrop = 18;
    rotateTextureToGravity = true;
    breakTime = 0.8;

}


BLOCKORECOPPER::~BLOCKORECOPPER() {
}

Dictionary BLOCKORECOPPER::onTick(int x, int y, PLANETDATA *planet, int dir){

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