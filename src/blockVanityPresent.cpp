#include "blockVanityPresent.h"
#include <godot_cpp/core/class_db.hpp>

#include <godot_cpp/variant/utility_functions.hpp>

#include "lookupBlock.h"

using namespace godot;

void BLOCKVANITYPRESENT::_bind_methods() {
}

BLOCKVANITYPRESENT::BLOCKVANITYPRESENT() {

    setTexture("res://items/gifts/presentWorld.png");

    breakTime = 0.8;

    breakParticleID = 8;

    hasCollision = false;

    lightMultiplier = 0.9;

    rotateTextureToGravity = true;

    connectTexturesToMe = false;

    itemToDrop = 3078;

    isTransparent = true;
    soundMaterial = 5;

}


BLOCKVANITYPRESENT::~BLOCKVANITYPRESENT() {
}

