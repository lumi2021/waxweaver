#include "blockRubber.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKRUBBER::_bind_methods() {
}

BLOCKRUBBER::BLOCKRUBBER() {

    setTexture("res://items/electrical/rubber.png");

    itemToDrop = 166;
    rotateTextureToGravity = true;
    soundMaterial = 0;

}


BLOCKRUBBER::~BLOCKRUBBER() {
}

Dictionary BLOCKRUBBER::onEnergize(int x, int y, PLANETDATA *planet, int dir){
    Dictionary changes = {};
	
	changes[Vector2i(x,y)] = 166;
    
	return changes;

}