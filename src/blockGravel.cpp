#include "blockGravel.h"
#include <godot_cpp/core/class_db.hpp>
#include "lookupBlock.h"

using namespace godot;

void BLOCKGRAVEL::_bind_methods() {
}

BLOCKGRAVEL::BLOCKGRAVEL() {

    setTexture("res://items/blocks/natural/gravel.png");

    itemToDrop = 28;
    rotateTextureToGravity = true;
    breakTime = 0.4;

    soundMaterial = 3;

}


BLOCKGRAVEL::~BLOCKGRAVEL() {
}

Dictionary BLOCKGRAVEL::onTick(int x, int y, PLANETDATA *planet, int dir){
    Dictionary changes = {};

    Vector2i blockBelow =  Vector2i(x,y) + Vector2i( Vector2(0,1).rotated(acos(0.0)*dir) );
    int tile = planet->getTileData(blockBelow.x,blockBelow.y);
    if (tile <= 1){
        changes[Vector2i(x,y)] = 0;
        changes[Vector2i(blockBelow.x,blockBelow.y)] = 28; // block id here
    } else if ( !lookup->hasCollision(tile) ) {
        changes[Vector2i(x,y)] = -1;

    }
        
    return changes;

}