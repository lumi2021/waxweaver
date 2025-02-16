#include "blockTrophy.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKTROPHY::_bind_methods() {
}

BLOCKTROPHY::BLOCKTROPHY() {

    setTexture("res://items/blocks/furniture/trophies/trophies.png");

    itemToDrop = 130;
    multitile = true;
    rotateTextureToGravity = true;
    backgroundColorImmune = true;
    isTransparent = true;
    hasCollision = false;
    connectTexturesToMe = false;

}


BLOCKTROPHY::~BLOCKTROPHY() {
}

Dictionary BLOCKTROPHY::onTick(int x, int y, PLANETDATA *planet, int dir){

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
