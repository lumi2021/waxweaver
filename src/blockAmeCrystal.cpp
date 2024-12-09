#include "blockAmeCrystal.h"
#include <godot_cpp/core/class_db.hpp>

#include <godot_cpp/variant/utility_functions.hpp>

#include "lookupBlock.h"

using namespace godot;

void BLOCKAMECRYSTAL::_bind_methods() {
}

BLOCKAMECRYSTAL::BLOCKAMECRYSTAL() {

    setTexture("res://items/blocks/foliage/rockFoliage/crystal.png");

    breakTime = 1.0;

    breakParticleID = 80;

    hasCollision = false;
    rotateTextureToGravity = true;
    connectTexturesToMe = false;
    itemToDrop = 81;
    isTransparent = true;
    multitile = true;
    soundMaterial = 6;

}


BLOCKAMECRYSTAL::~BLOCKAMECRYSTAL() {
}

Dictionary BLOCKAMECRYSTAL::onTick(int x, int y, PLANETDATA *planet, int dir){
    Dictionary changes = {};


    int timeAlive = planet->getGlobalTick() - planet->getTimeData(x,y);

    Vector2i BREAK = Vector2i(Vector2(0,-1).rotated(acos(0.0)*dir));
    int whatsBelowMe = planet->getTileData(BREAK.x + x,BREAK.y + y);
    if( !lookup->hasCollision(whatsBelowMe) ){
        changes[Vector2i(x,y)] = -1;
        return changes;

    }


    int rand = std::rand();
    if(rand%800 == 0){
        changes[Vector2i(x,y)] = "sparkle";
    }


    return changes;
}