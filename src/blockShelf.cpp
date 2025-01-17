#include "blockShelf.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKSHELF::_bind_methods() {
}

BLOCKSHELF::BLOCKSHELF() {

    setTexture("res://items/blocks/furniture/other/shelf.png");

    itemToDrop = 120;
    rotateTextureToGravity = true;

    connectedTexture = true;
    connectTexturesToMe = false;
    connectToSelfOnly = true;
    hasCollision = false;
    isTransparent = true;


}


BLOCKSHELF::~BLOCKSHELF() {
}