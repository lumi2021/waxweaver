#include "blockStoneMossy.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKSTONEMOSSY::_bind_methods() {
}

BLOCKSTONEMOSSY::BLOCKSTONEMOSSY() {

    setTexture("res://items/blocks/natural/mossyStone.png");

    itemToDrop = 118;
    rotateTextureToGravity = true;
    natural = true;
}


BLOCKSTONEMOSSY::~BLOCKSTONEMOSSY() {
}

Dictionary BLOCKSTONEMOSSY::onTick(int x, int y, PLANETDATA *planet, int dir){
    Dictionary changes = {};

    int timeAlive =  planet->getGlobalTick() - planet->getTimeData(x,y);

    if(timeAlive > 9000){
        Vector2i above = Vector2i(Vector2(0,-1).rotated(acos(0.0)*dir));
        
        if(planet->getTileData(above.x + x,above.y + y) < 2){
            changes[ Vector2i(above.x + x,above.y + y) ] = 77;
        }

        planet->setTimeData(x,y,planet->getGlobalTick());
    }

    return changes;
}