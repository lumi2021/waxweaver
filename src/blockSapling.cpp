#include "blockSapling.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKSAPLING::_bind_methods() {
}

BLOCKSAPLING::BLOCKSAPLING() {

    setTexture("res://block_resources/block_textures/treeSapling.png");

    breakTime = 0.0;

    breakParticleID = 8;

    hasCollision = false;

    lightMultiplier = 1.0;

    rotateTextureToGravity = true;

    connectTexturesToMe = false;

}


BLOCKSAPLING::~BLOCKSAPLING() {
}

Dictionary BLOCKSAPLING::onTick(int x, int y, PLANETDATA *planet, int dir){
    Dictionary changes = {};
    
    int timeAlive = planet->getGlobalTick() - planet->getTimeData(x,y);
    if (timeAlive > 12){

        int treeHeight = (std::rand() % 4) + 4;

        for(int i = 0; i < treeHeight; i++){

            Vector2 poo = Vector2(0,-i).rotated(acos(0.0)*dir);

            changes[Vector2i(Vector2(x+poo.x,y+poo.y))] = 8;

        }
    }

    return changes;
}