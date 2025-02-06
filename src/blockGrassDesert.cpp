#include "blockGrassDesert.h"
#include <godot_cpp/core/class_db.hpp>
#include "lookupBlock.h"

using namespace godot;

void BLOCKGRASSDESERT::_bind_methods() {
}

BLOCKGRASSDESERT::BLOCKGRASSDESERT() {

    setTexture("res://items/blocks/foliage/desert/desertGrass.png");

    breakTime = 0.0;
    breakParticleID = 14;
    hasCollision = false;
    lightMultiplier = 1.0;
    rotateTextureToGravity = true;
    connectTexturesToMe = false;
    isTransparent = true;
    soundMaterial = 5;
    multitile = true;

}


BLOCKGRASSDESERT::~BLOCKGRASSDESERT() {
}

Dictionary BLOCKGRASSDESERT::onTick(int x, int y, PLANETDATA *planet, int dir){
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
