#include "blockLampOff.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKLAMPOFF::_bind_methods() {
}

BLOCKLAMPOFF::BLOCKLAMPOFF() {

    setTexture("res://items/electrical/lamp/lampOff.png");

    itemToDrop = 95;
    rotateTextureToGravity = true;

    soundMaterial = 6;
}


BLOCKLAMPOFF::~BLOCKLAMPOFF() {
}

Dictionary BLOCKLAMPOFF::onEnergize(int x, int y, PLANETDATA *planet, int dir){
    Dictionary changes = {};
	
	changes[Vector2i(x,y)] = 95;
    
	return changes;

}