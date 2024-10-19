#include "blockPaper.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKPAPER::_bind_methods() {
}

BLOCKPAPER::BLOCKPAPER() {

    setTexture("res://items/blocks/building/paper.png");

    itemToDrop = 61;
    rotateTextureToGravity = true;
    soundMaterial = 2;
    lightMultiplier = 0.8;
    backgroundColorImmune = true;

}


BLOCKPAPER::~BLOCKPAPER() {
}

