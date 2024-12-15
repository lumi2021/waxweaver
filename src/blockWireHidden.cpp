#include "blockWireHidden.h"
#include <godot_cpp/core/class_db.hpp>

#include "lookupBlock.h"

using namespace godot;

void BLOCKWIREHIDDEN::_bind_methods() {
}

BLOCKWIREHIDDEN::BLOCKWIREHIDDEN() {

    setTexture("res://items/electrical/wirehidden.png");

    itemToDrop = 93;
    rotateTextureToGravity = true;
    hasCollision = true;
    isTransparent = false;
    multitile = true;
}


BLOCKWIREHIDDEN::~BLOCKWIREHIDDEN() {
}

Dictionary BLOCKWIREHIDDEN::onEnergize(int x, int y, PLANETDATA *planet, int dir){
    Dictionary changes = {};

    int timeAlive = planet->getGlobalTick() - planet->getTimeData(x,y); // we check the time value to make sure tiles that have already been energized are not energized again
    if (timeAlive < 1){
        return changes;
    }

    planet->setTimeData( x,y, planet->getGlobalTick() ); // set time to global tick, so that future wires don't try to re-energize this block
    
    Dictionary brap = planet->energize(x,y,planet,lookup);
    changes.merge( brap ); // get dictionary about future energizations, this will stack
    
    if (brap.is_empty()){
        changes[Vector2i(x,y)] = "spark"; // if there are no tiles to be edited, play spark animation. nice effect for loose wires
    }
    return changes;
}