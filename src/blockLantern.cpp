#include "blockLantern.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKLANTERN::_bind_methods() {
}

BLOCKLANTERN::BLOCKLANTERN() {

    setTexture("res://items/blocks/furniture/lights/lantern.png");

    itemToDrop = 125;
    rotateTextureToGravity = true;

    connectTexturesToMe = false;
    hasCollision = false;
    isTransparent = true;
    breakTime = 0.25;
    breakParticleID = 5;

    lightEmmission = 1.3;


}


BLOCKLANTERN::~BLOCKLANTERN() {
}