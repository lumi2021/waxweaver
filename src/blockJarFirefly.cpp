#include "blockJarFirefly.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKJARFIREFLY::_bind_methods() {
}

BLOCKJARFIREFLY::BLOCKJARFIREFLY() {

    setTexture("res://items/blocks/furniture/lights/fireflyJar.png");

    itemToDrop = 73;
    rotateTextureToGravity = true;
    soundMaterial = 6;
    animated = true;
    connectTexturesToMe = false;
    lightEmmission = 1.0;
    hasCollision = false;
    isTransparent = true;

}


BLOCKJARFIREFLY::~BLOCKJARFIREFLY() {
}

