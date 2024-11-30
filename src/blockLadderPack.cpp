#include "blockLadderPack.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKLADDERPACK::_bind_methods() {
}

BLOCKLADDERPACK::BLOCKLADDERPACK() {

    setTexture("res://items/blocks/furniture/other/ladderPack.png");

    itemToDrop = 25;
    rotateTextureToGravity = true;
    hasCollision = false;
    isTransparent = true;
    connectTexturesToMe = false;
    lightMultiplier = 0.92;
    breakTime = 4.0;
    soundMaterial = 2;
}


BLOCKLADDERPACK::~BLOCKLADDERPACK() {
}

Dictionary BLOCKLADDERPACK::onTick(int x, int y, PLANETDATA *planet, int dir){

    Dictionary changes = {};
    
    int amountleft = planet->getInfoData(x,y);

    if (amountleft == 0){
        changes[Vector2i(x,y)] = 25;
        return changes;
    }

    changes[Vector2i(x,y)] = 25;

    Vector2i below = Vector2i(Vector2(0,1).rotated(acos(0.0)*dir));

    if (planet->getTileData( below.x + x,below.y + y ) > 1){
        return changes;
    }

    changes[Vector2i(below.x + x,below.y + y)] = 79;
    planet->setInfoData(below.x + x,below.y + y,amountleft - 1);


	return changes;
}