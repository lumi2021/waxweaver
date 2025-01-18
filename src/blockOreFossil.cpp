#include "blockOreFossil.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKOREFOSSIL::_bind_methods() {
}

BLOCKOREFOSSIL::BLOCKOREFOSSIL() {

    setTexture("res://items/blocks/ores/fossil.png");

    itemToDrop = 128;
    rotateTextureToGravity = true;
    breakTime = 4.5;
    miningLevel = 4;

}


BLOCKOREFOSSIL::~BLOCKOREFOSSIL() {
}

Dictionary BLOCKOREFOSSIL::onTick(int x, int y, PLANETDATA *planet, int dir){

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