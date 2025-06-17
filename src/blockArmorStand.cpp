#include "blockArmorStand.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKARMORSTAND::_bind_methods() {
}

BLOCKARMORSTAND::BLOCKARMORSTAND() {

    setTexture("res://items/blocks/furniture/armorstand/armorstandreal.png");

    //multitile = true;
    //rotateTextureToGravity = true;
    hasCollision = false;
    connectTexturesToMe = false;
    itemToDrop = 167;
    isTransparent = true;

}


BLOCKARMORSTAND::~BLOCKARMORSTAND() {
}

Dictionary BLOCKARMORSTAND::onBreak(int x, int y, PLANETDATA *planet, int dir){

    Dictionary changes = {};

    int multitileInfo = planet->getInfoData(x,y);

    if (multitileInfo > 1){
        multitileInfo = 1;
    }

    if (multitileInfo < 0){
        multitileInfo = 0;
    }

    // determine size of multiTile
    
    Vector2i size = Vector2i(1,2);
   

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

Dictionary BLOCKARMORSTAND::onLoad(int x, int y, PLANETDATA *planet, int dir){

    Dictionary changes = {};

    int multitileInfo = planet->getInfoData(x,y);

    if (multitileInfo > 0){
        changes[Vector2i(x,y)] = "summonArmorStand";
    }

    return changes;
}