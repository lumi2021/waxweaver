#include "blockObserver.h"
#include <godot_cpp/core/class_db.hpp>

#include "lookupBlock.h"

using namespace godot;

void BLOCKOBSERVER::_bind_methods() {
}

BLOCKOBSERVER::BLOCKOBSERVER() {

    setTexture("res://items/electrical/input/observer.png");

    itemToDrop = 98;
    rotateTextureToGravity = false;
    multitile = true;


}


BLOCKOBSERVER::~BLOCKOBSERVER() {
}

Dictionary BLOCKOBSERVER::onTick(int x, int y, PLANETDATA *planet, int dir){
    Dictionary changes = {};
	
    int info = planet->getInfoData(x,y);

    if (info % 2 == 1){ // disable energize frame
        planet->setInfoData(x,y,info - 1);
        changes[Vector2i(x,y)] = 98;
        return changes;
    }

    int rot = info / 2;
    Vector2i scan = Vector2i( Vector2( 1,0 ).rotated(acos(0.0)*rot) );

    int tile = planet->getTileData(x+scan.x,y+scan.y);
    int time = planet->getTimeData(x,y);
    if(tile != time){
        planet->setInfoData(x,y,info + 1); // make light up
        planet->setTimeData(x,y,tile);
        changes[Vector2i(x,y)] = 98; // edit so we redraw
        changes.merge(planet->energize(x,y,planet,lookup)); // energize self
    }
	
    
	return changes;

}