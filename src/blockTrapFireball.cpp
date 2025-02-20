#include "blockTrapFireball.h"
#include <godot_cpp/core/class_db.hpp>

#include "lookupBlock.h"

using namespace godot;

void BLOCKTRAPFIREBALL::_bind_methods() {
}

BLOCKTRAPFIREBALL::BLOCKTRAPFIREBALL() {

    setTexture("res://items/electrical/trap/fireballTrap.png");

    itemToDrop = 153;
    rotateTextureToGravity = false;
    multitile = true;
    isTransparent = true;
    hasCollision = false;


}


BLOCKTRAPFIREBALL::~BLOCKTRAPFIREBALL() {
}

Dictionary BLOCKTRAPFIREBALL::onEnergize(int x, int y, PLANETDATA *planet, int dir){
    Dictionary changes = {};

    int timeAlive = planet->getGlobalTick() - planet->getTimeData(x,y);

    if(timeAlive < 15){
        return changes;
    }
	
    changes[Vector2i(x,y)] = "trapfireball";

    
	planet->setTimeData(x,y,planet->getGlobalTick());
    
	return changes;

}