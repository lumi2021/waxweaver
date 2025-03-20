#include "blockNumberScanner.h"
#include <godot_cpp/core/class_db.hpp>

#include "lookupBlock.h"

using namespace godot;

void BLOCKNUMBERSCANNER::_bind_methods() {
}

BLOCKNUMBERSCANNER::BLOCKNUMBERSCANNER() {

    setTexture("res://items/electrical/input/numberScanner.png");

    itemToDrop = 160;
    rotateTextureToGravity = true;
    multitile = true;


}


BLOCKNUMBERSCANNER::~BLOCKNUMBERSCANNER() {
}

Dictionary BLOCKNUMBERSCANNER::onTick(int x, int y, PLANETDATA *planet, int dir){
    Dictionary changes = {};
	
    int info = planet->getInfoData(x,y);


    Vector2i scan = Vector2i( Vector2( 0,1 ).rotated(acos(0.0)*dir) );

    int tile = planet->getInfoData(x+scan.x,y+scan.y);
    int time = planet->getTimeData(x,y);
    if(tile != time){
        planet->setTimeData(x,y,tile); // tile info has changed
        if (info == tile){ // if tileinfo matches the number displayed
            changes.merge(planet->energize(x,y,planet,lookup)); // energize self
        }
    }
	
    
	return changes;

}