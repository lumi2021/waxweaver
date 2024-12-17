#include "blockPlacer.h"
#include <godot_cpp/core/class_db.hpp>

#include "lookupBlock.h"

using namespace godot;

void BLOCKPLACER::_bind_methods() {
}

BLOCKPLACER::BLOCKPLACER() {

    setTexture("res://items/electrical/placer/placer.png");

    itemToDrop = 104;
    rotateTextureToGravity = false;
    multitile = true;
    isTransparent = true;


}


BLOCKPLACER::~BLOCKPLACER() {
}

Dictionary BLOCKPLACER::onEnergize(int x, int y, PLANETDATA *planet, int dir){
    Dictionary changes = {};
	
    int info = planet->getInfoData(x,y);

    int rot = info;
    Vector2i scan = Vector2i( Vector2( 1,0 ).rotated(acos(0.0)*rot) );
    Vector2i chestScan = Vector2i( Vector2( -1,0 ).rotated(acos(0.0)*rot) );

    int tile = planet->getTileData(x+scan.x,y+scan.y);
    int chest = planet->getTileData(x+chestScan.x,y+chestScan.y);
    if(tile < 2 && chest == 33){
        changes[Vector2i(x,y)] = "placer";
    }
	
    
	return changes;

}