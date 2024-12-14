#include "blockLampOn.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKLAMPON::_bind_methods() {
}

BLOCKLAMPON::BLOCKLAMPON() {

    setTexture("res://items/electrical/lamp/lampOn.png");

    itemToDrop = 95;
    rotateTextureToGravity = true;

    lightEmmission = 1.4;
    soundMaterial = 6;
}


BLOCKLAMPON::~BLOCKLAMPON() {
}

Dictionary BLOCKLAMPON::onEnergize(int x, int y, PLANETDATA *planet, int dir){
    Dictionary changes = {};
	
	changes[Vector2i(x,y)] = 96;
    
	return changes;

}