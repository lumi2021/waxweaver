#include "blockBook.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKBOOK::_bind_methods() {
}

BLOCKBOOK::BLOCKBOOK() {

    setTexture("res://items/blocks/furniture/other/books.png");

    itemToDrop = 121;
    rotateTextureToGravity = true;

    connectTexturesToMe = false;
    hasCollision = false;
    isTransparent = true;
    multitile = true;


}


BLOCKBOOK::~BLOCKBOOK() {
}