#include "blockDoorOpen.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKDOOROPEN::_bind_methods() {
}

BLOCKDOOROPEN::BLOCKDOOROPEN() {

    setTexture("res://items/blocks/furniture/doors/allDoorsOpen.png");

    multitile = true;
    rotateTextureToGravity = true;
    hasCollision = false;
    connectTexturesToMe = false;
    lightMultiplier = 0.99;
    itemToDrop = 23;
    breakParticleID = 2;
    isTransparent = true;
    soundMaterial = 2;

}


BLOCKDOOROPEN::~BLOCKDOOROPEN() {
}

Dictionary BLOCKDOOROPEN::onBreak(int x, int y, PLANETDATA *planet, int dir){

    Dictionary changes = {};

    int multitileInfo = planet->getInfoData(x,y) % 4;

    // determine size of multiTile
    
    Vector2i size = Vector2i(2,2);
   

    // find coords of info tile
    int mltY = multitileInfo / size.x;
    int mltX = (size.x * mltY * -1) + multitileInfo;

    for (int xi = 0; xi < size.x; xi++){
        for (int yi = 0; yi < size.y; yi++){
            // go throguh each tile
            Vector2 rot = Vector2( xi - mltX , yi - mltY ).rotated(acos(0.0)*dir);
            int worldX = x + rot.x;
            int worldY = y + rot.y;

            Vector2i replacePos = Vector2i( worldX,worldY  );
            changes[replacePos] = 0;

        }
    }

   
    return changes;

}