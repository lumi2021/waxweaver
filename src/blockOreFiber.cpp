#include "blockOreFiber.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKOREFIBER::_bind_methods() {
}

BLOCKOREFIBER::BLOCKOREFIBER() {

    setTexture("res://items/blocks/ores/ancientFiber.png");

    itemToDrop = 113;
    rotateTextureToGravity = true;
    breakTime = 3.0;
    miningLevel = 3;

}


BLOCKOREFIBER::~BLOCKOREFIBER() {
}

Dictionary BLOCKOREFIBER::onTick(int x, int y, PLANETDATA *planet, int dir){

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