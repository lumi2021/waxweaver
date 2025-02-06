#include "blockSandstoneEye.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKSANDSTONEEYE::_bind_methods() {
}

BLOCKSANDSTONEEYE::BLOCKSANDSTONEEYE() {

    setTexture("res://items/blocks/building/sandstoneEye.png");

    itemToDrop = 138;
    rotateTextureToGravity = true;

}


BLOCKSANDSTONEEYE::~BLOCKSANDSTONEEYE() {
}