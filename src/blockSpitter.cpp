#include "blockSpitter.h"
#include <godot_cpp/core/class_db.hpp>

#include "lookupBlock.h"

using namespace godot;

void BLOCKSPITTER::_bind_methods() {
}

BLOCKSPITTER::BLOCKSPITTER() {

    setTexture("res://items/electrical/spitter/spitter.png");

    itemToDrop = 102;
    rotateTextureToGravity = false;
    multitile = true;
    isTransparent = true;
    animated = true;


}


BLOCKSPITTER::~BLOCKSPITTER() {
}

Dictionary BLOCKSPITTER::onEnergize(int x, int y, PLANETDATA *planet, int dir){
    Dictionary changes = {};
	
    int info = planet->getInfoData(x,y);

    int rot = info;
    Vector2i scan = Vector2i( Vector2( 1,0 ).rotated(acos(0.0)*rot) );
    Vector2i scan2 = Vector2i( Vector2( 2,0 ).rotated(acos(0.0)*rot) );

    int tile = planet->getTileData(x+scan.x,y+scan.y);
    if(tile > 1){

        int tile2 = planet->getTileData(x+scan2.x,y+scan2.y);
        if(tile2 < 2){
            changes[Vector2i(x,y)] = "spitter";
        }
    }
	
    
	return changes;

}