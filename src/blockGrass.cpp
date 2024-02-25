#include "blockGrass.h"
#include <godot_cpp/core/class_db.hpp>


using namespace godot;

void BLOCKGRASS::_bind_methods() {
}

BLOCKGRASS::BLOCKGRASS() {

    setTexture("res://block_resources/block_textures/grass.png");

    connectedTexture = true;

    itemToDrop = 0;
    breakParticleID = 3;

}


BLOCKGRASS::~BLOCKGRASS() {
}

Dictionary BLOCKGRASS::onTick(int x, int y, PLANETDATA *planet, int dir) {


    Dictionary changes = {};

    changes["cunt!!"] = 5;

    return changes;
}