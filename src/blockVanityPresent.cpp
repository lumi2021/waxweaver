#include "blockVanityPresent.h"
#include <godot_cpp/core/class_db.hpp>

#include <godot_cpp/variant/utility_functions.hpp>

#include "lookupBlock.h"

using namespace godot;

void BLOCKVANITYPRESENT::_bind_methods() {
}

BLOCKVANITYPRESENT::BLOCKVANITYPRESENT() {

    setTexture("res://items/gifts/presentWorld.png");

    breakTime = 0.8;

    breakParticleID = 8;

    hasCollision = false;

    lightMultiplier = 0.9;

    rotateTextureToGravity = true;

    connectTexturesToMe = false;

    itemToDrop = 3078;

    isTransparent = true;
    soundMaterial = 5;

}


BLOCKVANITYPRESENT::~BLOCKVANITYPRESENT() {
}

Dictionary BLOCKVANITYPRESENT::onTick(int x, int y, PLANETDATA *planet, int dir){
    Dictionary changes = {};


    int timeAlive = planet->getGlobalTick() - planet->getTimeData(x,y);

    Vector2i BREAK = Vector2i(Vector2(0,1).rotated(acos(0.0)*dir));
    int whatsBelowMe = planet->getTileData(BREAK.x + x,BREAK.y + y);
    if( !lookup->hasCollision(whatsBelowMe) ){
        changes[Vector2i(x,y)] = -1;
        return changes;

    }


    return changes;
}