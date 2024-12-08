#include "blockCore.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKCORE::_bind_methods() {
}

BLOCKCORE::BLOCKCORE() {

    setTexture("res://items/blocks/natural/core.png");

    breakTime = 5.0;
    miningLevel = 1000;

}


BLOCKCORE::~BLOCKCORE() {
}


Dictionary BLOCKCORE::onTick(int x, int y, PLANETDATA *planet, int dir){
    
	Dictionary changes = {};
    
    int timeAlive = planet->getGlobalTick() - planet->getTimeData(x,y);
    if (timeAlive < 1000){
        return changes;
    }
            
    Vector2i above = Vector2i(Vector2(0,-1).rotated(acos(0.0)*dir));
    if( planet->getTileData(above.x + x,above.y + y) > 1 ){
        planet->setTimeData(x,y,planet->getGlobalTick());
        return changes;
    }

    if(std::rand() % 10 != 0 ){ 
        planet->setTimeData(x,y,planet->getGlobalTick());
        return changes; 
    }

    changes[Vector2i(above.x + x,above.y + y)] = 82;
    planet->setInfoData(above.x + x,above.y + y, std::rand() % 3 );
    

        


	return changes;

}
