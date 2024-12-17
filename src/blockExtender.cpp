#include "blockExtender.h"
#include <godot_cpp/core/class_db.hpp>

#include "lookupBlock.h"

using namespace godot;

void BLOCKEXTENDER::_bind_methods() {
}

BLOCKEXTENDER::BLOCKEXTENDER() {

    setTexture("res://items/electrical/input/extender.png");

    itemToDrop = 103;
    rotateTextureToGravity = false;
    multitile = true;
    isTransparent = true;


}


BLOCKEXTENDER::~BLOCKEXTENDER() {
}

Dictionary BLOCKEXTENDER::onEnergize(int x, int y, PLANETDATA *planet, int dir){
    Dictionary changes = {};
	
    int info = planet->getInfoData(x,y);

    int rot = info;
    Vector2i scan = Vector2i( Vector2( 1,0 ).rotated(acos(0.0)*rot) );

    int timeAlive = planet->getGlobalTick() - planet->getTimeData(x,y);
    if(timeAlive < 1){ // we check this so that extenders dont loop, looping extenders cause crashes
        return changes;
    }
    
    planet->setTimeData(x,y,planet->getGlobalTick());
    
    for(int i = 1; i < 10; i++ ){
        Vector2i brap = scan * i;
        int tile = planet->getTileData( x+brap.x,y+brap.y );

        changes.merge( lookup->runOnEnergize(x + brap.x,y + brap.y,planet,dir,tile) );

        if( !changes.is_empty() ){
            return changes;
        }
    
    }
    
	return changes;

}