#include "block.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCK::_bind_methods() {
}

BLOCK::BLOCK() {
    //Default Variables
    blockID = -1;

    ResourceLoader rl;
    texture = rl.load("res://block_resources/block_textures/error.png");

    rotateTextureToGravity = false;
    connectedTexture = false;
    connectTexturesToMe = true;

    hasCollision = true;

    lightMultiplier = 0.9;
    lightEmmission = 0.0;

    // -1 drops nothing
    itemToDrop = -1;

    // -1 = particles match texture
    breakParticleID = -1;

    // in seconds
    breakTime = 0.5;

    setNewVariables();

}

BLOCK::~BLOCK() {
}

void BLOCK::setNewVariables(){
}

Dictionary BLOCK::onTick(int x, int y, Array planetData, int layer, int dir){
    Dictionary changes = {};
    return changes;
}
