#include "blockShopComputer.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKSHOPCOMPUTER::_bind_methods() {
}

BLOCKSHOPCOMPUTER::BLOCKSHOPCOMPUTER() {

    setTexture("res://items/blocks/furniture/shop/computer.png");

    itemToDrop = 139;
    rotateTextureToGravity = true;

    connectTexturesToMe = false;
    hasCollision = false;
    isTransparent = true;


}


BLOCKSHOPCOMPUTER::~BLOCKSHOPCOMPUTER() {
}