#include "blockCampfire.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKCAMPFIRE::_bind_methods() {
}

BLOCKCAMPFIRE::BLOCKCAMPFIRE() {

    setTexture("res://items/blocks/furniture/lights/campfire.png");

    multitile = true;
    rotateTextureToGravity = true;
    hasCollision = false;
    connectTexturesToMe = false;
    itemToDrop = 117;
    isTransparent = true;
    animated = true;
    lightEmmission = 1.0;

}


BLOCKCAMPFIRE::~BLOCKCAMPFIRE() {
}

Dictionary BLOCKCAMPFIRE::onBreak(int x, int y, PLANETDATA *planet, int dir){

    Dictionary changes = {};

    int multitileInfo = planet->getInfoData(x,y);

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

Dictionary BLOCKCAMPFIRE::onTick(int x, int y, PLANETDATA *planet, int dir){
    
    Dictionary changes = {};
    
        int tick = planet->getGlobalTick();
        if( tick % 60 == 0 ){
            if( std::rand() % 12 == 0 ){
                changes[ Vector2i(x,y) ] = "furnacesound";
            }

        }

	return changes;

}