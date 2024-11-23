#include "blockBrownBrick.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKBROWNBRICK::_bind_methods() {
}

BLOCKBROWNBRICK::BLOCKBROWNBRICK() {

    setTexture("res://items/blocks/building/brownBrick.png");

    itemToDrop = 65;
    rotateTextureToGravity = true;
    soundMaterial = 1;

}


BLOCKBROWNBRICK::~BLOCKBROWNBRICK() {
}