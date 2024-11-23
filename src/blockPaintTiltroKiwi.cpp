#include "blockPaintTiltroKiwi.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKPAINTTILTROKIWI::_bind_methods() {
}

BLOCKPAINTTILTROKIWI::BLOCKPAINTTILTROKIWI() {

    setTexture("res://items/paintings/tiltroKiwi.png");

    multitile = true;
    rotateTextureToGravity = true;
    hasCollision = false;
    connectTexturesToMe = false;
    lightMultiplier = 0.99;
    itemToDrop = 66;
    isTransparent = true;
    breakParticleID = 14;
    soundMaterial = 2;
}


BLOCKPAINTTILTROKIWI::~BLOCKPAINTTILTROKIWI() {
}

Dictionary BLOCKPAINTTILTROKIWI::onTick(int x, int y, PLANETDATA *planet, int dir){
    
		Dictionary changes = {};

        int bg = planet->getBGData(x,y);
        if (bg<2){
            changes[Vector2i(x,y)] = -1;
        }

		return changes;

	}

Dictionary BLOCKPAINTTILTROKIWI::onBreak(int x, int y, PLANETDATA *planet, int dir){

    Dictionary changes = {};

    int multitileInfo = planet->getInfoData(x,y);

    // determine size of multiTile
    
    Vector2i size = Vector2i(2,3);

   

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