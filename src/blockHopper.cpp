#include "blockHopper.h"
#include <godot_cpp/core/class_db.hpp>

#include "lookupBlock.h"

using namespace godot;

void BLOCKHOPPER::_bind_methods() {
}

BLOCKHOPPER::BLOCKHOPPER() {

    setTexture("res://items/electrical/hopper/hopper.png");

    itemToDrop = 107;
    rotateTextureToGravity = true;
    isTransparent = true;


}


BLOCKHOPPER::~BLOCKHOPPER() {
}

Dictionary BLOCKHOPPER::onEnergize(int x, int y, PLANETDATA *planet, int dir){
    Dictionary changes = {};
	
    int info = planet->getInfoData(x,y);

    int rot = info;
    Vector2i chestScan = Vector2i( Vector2( 0,1 ).rotated(acos(0.0)*dir) ); // searches downward for chest

    int chest = planet->getTileData(x+chestScan.x,y+chestScan.y);
    if(chest == 33){
        changes[Vector2i(x,y)] = "hopper";
    }
	
    
	return changes;

}