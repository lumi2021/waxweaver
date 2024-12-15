#include "blockDrill.h"
#include <godot_cpp/core/class_db.hpp>

#include "lookupBlock.h"

using namespace godot;

void BLOCKDRILL::_bind_methods() {
}

BLOCKDRILL::BLOCKDRILL() {

    setTexture("res://items/electrical/drill/drill.png");

    itemToDrop = 101;
    rotateTextureToGravity = false;
    multitile = true;
    isTransparent = true;


}


BLOCKDRILL::~BLOCKDRILL() {
}

Dictionary BLOCKDRILL::onEnergize(int x, int y, PLANETDATA *planet, int dir){
    Dictionary changes = {};
	
    int info = planet->getInfoData(x,y);

    int rot = info;
    Vector2i scan = Vector2i( Vector2( 1,0 ).rotated(acos(0.0)*rot) );

    int tile = planet->getTileData(x+scan.x,y+scan.y);
    if(tile > 1){

        changes[Vector2i(x+scan.x,y+scan.y)] = -1;
    }
	
    
	return changes;

}