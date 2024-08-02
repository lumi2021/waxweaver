#include "blockSand.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKSAND::_bind_methods() {
}

BLOCKSAND::BLOCKSAND() {

    setTexture("res://items/blocks/natural/sand.png");

    itemToDrop = 14;
    rotateTextureToGravity = true;

}


BLOCKSAND::~BLOCKSAND() {
}

Dictionary BLOCKSAND::onTick(int x, int y, PLANETDATA *planet, int dir){
    Dictionary changes = {};

    Vector2i blockBelow =  Vector2i(x,y) + Vector2i( Vector2(0,1).rotated(acos(0.0)*dir) );
    int tile = planet->getTileData(blockBelow.x,blockBelow.y);
    if (tile <= 1){
        changes[Vector2i(x,y)] = 0;
        changes[Vector2i(blockBelow.x,blockBelow.y)] = 14;
    }
        
    return changes;

}