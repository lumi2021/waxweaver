#include "blockOreGoldDesert.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKOREGOLDDESERT::_bind_methods() {
}

BLOCKOREGOLDDESERT::BLOCKOREGOLDDESERT() {

    setTexture("res://items/blocks/ores/desertGold.png");

    itemToDrop = 24;
    rotateTextureToGravity = true;
    breakTime = 1.0;
    miningLevel = 1;

}


BLOCKOREGOLDDESERT::~BLOCKOREGOLDDESERT() {
}

Dictionary BLOCKOREGOLDDESERT::onTick(int x, int y, PLANETDATA *planet, int dir){

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