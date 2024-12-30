#include "blockTrapdoorOpen.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKTRAPDOOROPEN::_bind_methods() {
}

BLOCKTRAPDOOROPEN::BLOCKTRAPDOOROPEN() {

    setTexture("res://items/blocks/furniture/trapdoors/allTrapdoorsOpen.png");

    itemToDrop = 47;
    rotateTextureToGravity = true;
    hasCollision = false;
    multitile = true;
    isTransparent = true;
    connectTexturesToMe = false;
    soundMaterial = 2;
    

}


BLOCKTRAPDOOROPEN::~BLOCKTRAPDOOROPEN() {
}

Dictionary BLOCKTRAPDOOROPEN::onEnergize(int x, int y, PLANETDATA *planet, int dir){
    Dictionary changes = {};

    changes[ Vector2i(x,y) ] = "trapdoorClose";

    return changes;

}