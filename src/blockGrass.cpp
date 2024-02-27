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

    if ( planet->getGlobalTick() - planet->getTimeData(x,y) > 60){
        int freeRight = planet->getTileData(x+1,y);

        if (freeRight < 2){
            changes[Vector2i(x,y)] = freeRight;
            changes[Vector2i(x+1,y)] = 4;
        }
    }
    
    return changes;
    
}