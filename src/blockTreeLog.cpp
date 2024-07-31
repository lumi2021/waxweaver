#include "blockTreeLog.h"
#include "lookupBlock.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKTREELOG::_bind_methods() {
}

BLOCKTREELOG::BLOCKTREELOG() {

    setTexture("res://block_resources/block_textures/log.png");

    breakTime = 1.0;

    breakParticleID = -1;

    hasCollision = false;

    lightMultiplier = 0.99;

    rotateTextureToGravity = true;

    connectTexturesToMe = false;

    itemToDrop = 13;

}


BLOCKTREELOG::~BLOCKTREELOG() {
}


Dictionary BLOCKTREELOG::onTick(int x, int y, PLANETDATA *planet, int dir){
    
    Dictionary changes = {};

    //Vector2i BREAK = Vector2i(Vector2(0,1).rotated(acos(0.0)*dir));
    //int tileBelow = planet->getTileData(BREAK.x + x,BREAK.y + y);

    //if ( !lookup->hasCollision(tileBelow) && tileBelow != 8){
    //    changes[Vector2i(x,y)] = -1;

    //}

    return changes;

}

Dictionary BLOCKTREELOG::onBreak(int x, int y, PLANETDATA *planet, int dir){

    Dictionary changes = {};

    Vector2i newPos =  Vector2i(x,y) - Vector2i( Vector2(0,1).rotated(acos(0.0)*dir) );
    int tileAbove = planet->getTileData(newPos.x,newPos.y);

    if (tileAbove == 12 || tileAbove == 8){
        changes[newPos] = -1;

    }

    newPos =  Vector2i(x,y) + Vector2i( Vector2(1,0).rotated(acos(0.0)*dir) );
    int tileRight = planet->getTileData(newPos.x,newPos.y);

    if (tileRight == 10 || tileRight == 11 || tileRight == 12){
        changes[newPos] = -1;

    }

    newPos =  Vector2i(x,y) + Vector2i( Vector2(-1,0).rotated(acos(0.0)*dir) );
    int tileLeft = planet->getTileData(newPos.x,newPos.y);

    if (tileLeft == 10 || tileLeft == 11 || tileLeft == 12){
        changes[newPos] = -1;

    }
   
   
   
    return changes;

}