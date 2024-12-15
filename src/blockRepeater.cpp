#include "blockRepeater.h"
#include <godot_cpp/core/class_db.hpp>

#include "lookupBlock.h"

using namespace godot;

void BLOCKREPEATER::_bind_methods() {
}

BLOCKREPEATER::BLOCKREPEATER() {

    setTexture("res://items/electrical/input/repeater.png");

    itemToDrop = 100;
    rotateTextureToGravity = false;
    multitile = true;


}


BLOCKREPEATER::~BLOCKREPEATER() {
}

Dictionary BLOCKREPEATER::onTick(int x, int y, PLANETDATA *planet, int dir){
    Dictionary changes = {};
	
    int info = planet->getInfoData(x,y);
    int timeAlive = planet->getGlobalTick() - planet->getTimeData(x,y);

    if (info % 2 == 1){ // if energized
        if( timeAlive > 15 ){

            int rot = info / 2;
            Vector2i scan = Vector2i( Vector2( 1,0 ).rotated(acos(0.0)*rot) );

            int tile = planet->getTileData( x+scan.x,y+scan.y );
            changes.merge( lookup->runOnEnergize(x+scan.x,y+scan.y,planet,dir,tile) );
            
            planet->setInfoData(x,y,info - 1);
            changes[Vector2i(x,y)] = 100;
        } 
        return changes;
    }

	return changes;

}

Dictionary BLOCKREPEATER::onEnergize(int x, int y, PLANETDATA *planet, int dir){
    Dictionary changes = {};

    int info = planet->getInfoData(x,y);
    if (info % 2 == 1){ // if energized
        return changes;
    }

    planet->setTimeData(x,y,planet->getGlobalTick());
    planet->setInfoData(x,y,info + 1);
    changes[Vector2i(x,y)] = 100;
	
	return changes;

}