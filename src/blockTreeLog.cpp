#include "blockTreeLog.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKTREELOG::_bind_methods() {
}

BLOCKTREELOG::BLOCKTREELOG() {

    setTexture("res://block_resources/block_textures/log.png");

    breakTime = 1.0;

    breakParticleID = -1;

    hasCollision = false;

    lightMultiplier = 1.0;

    rotateTextureToGravity = true;

    connectTexturesToMe = false;

}


BLOCKTREELOG::~BLOCKTREELOG() {
}

