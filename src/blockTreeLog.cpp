#include "blockTreeLog.h"
#include "lookupBlock.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKTREELOG::_bind_methods() {
}

BLOCKTREELOG::BLOCKTREELOG() {

    setTexture("res://items/blocks/foliage/trees/forestTree/log.png");

    breakTime = 1.0;

    breakParticleID = -1;

    hasCollision = false;

    lightMultiplier = 0.8;

    rotateTextureToGravity = true;

    connectTexturesToMe = false;

    itemToDrop = 13;

    soundMaterial = 2;

    isTransparent = true;

}


BLOCKTREELOG::~BLOCKTREELOG() {
}


Dictionary BLOCKTREELOG::onTick(int x, int y, PLANETDATA *planet, int dir){
    
    Dictionary changes = {};

    Vector2i BREAK = Vector2i(Vector2(0,1).rotated(acos(0.0)*dir));
    int tileBelow = planet->getTileData(BREAK.x + x,BREAK.y + y);

    if ( !lookup->hasCollision(tileBelow) && tileBelow != 8){
        changes[Vector2i(x,y)] = -1;

    }

    return changes;

}

Dictionary BLOCKTREELOG::onBreak(int x, int y, PLANETDATA *planet, int dir){

    Dictionary changes = {};

    Vector2i newPos =  Vector2i(x,y) - Vector2i( Vector2(0,1).rotated(acos(0.0)*dir) );
    int tileAbove = planet->getTileData(newPos.x,newPos.y);

    if (tileAbove != 8){

        for (int xx = 0; xx < 5; xx++){
            for (int yy = 0; yy < 5; yy++){

                Vector2i scrapPos =  Vector2i( xx - 2,yy - 2 ) + Vector2i(x,y);
                int tile = planet->getTileData(scrapPos.x,scrapPos.y);
                if (tile == 12 || tile == 10 || tile == 11){

                    changes[scrapPos] = -1;
                }
        
        
            }
        }

    }

   
    return changes;

}