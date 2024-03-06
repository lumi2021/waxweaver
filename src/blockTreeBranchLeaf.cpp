#include "blockTreeBranchLeaf.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKTREEBRANCHLEAF::_bind_methods() {
}

BLOCKTREEBRANCHLEAF::BLOCKTREEBRANCHLEAF() {

    setTexture("res://block_resources/block_textures/leavesBranch.png");

    breakTime = 1.0;

    breakParticleID = -1;

    hasCollision = false;

   lightMultiplier = 1.0;

    rotateTextureToGravity = true;

    connectTexturesToMe = false;

}


BLOCKTREEBRANCHLEAF::~BLOCKTREEBRANCHLEAF() {
}

Dictionary BLOCKTREEBRANCHLEAF::onBreak(int x, int y, PLANETDATA *planet, int dir){

    Dictionary changes = {};

    Vector2i newPos =  Vector2i(x,y) - Vector2i( Vector2(0,1).rotated(acos(0.0)*dir) );
    int tileAbove = planet->getTileData(newPos.x,newPos.y);

    if (tileAbove == 8 || tileAbove == 12){
        changes[newPos] = -1;

    }

    newPos =  Vector2i(x,y) + Vector2i( Vector2(1,0).rotated(acos(0.0)*dir) );
    int tileRight = planet->getTileData(newPos.x,newPos.y);

    if (tileRight == 10 || tileRight == 11 || tileRight == 12){
        changes[newPos] = -1;

    }

    newPos =  Vector2i(x,y) + Vector2i( Vector2(-1,0).rotated(acos(0.0)*dir) );
    int tileLeft = planet->getTileData(newPos.x,newPos.y);

    if (tileLeft == 10 || tileLeft == 11 || tileLeft == 12){
        changes[newPos] = -1;

    }
   
   
   
    return changes;

}