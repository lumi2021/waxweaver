#include "blockSunflowerStem.h"
#include "lookupBlock.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKSUNFLOWERSTEM::_bind_methods() {
}

BLOCKSUNFLOWERSTEM::BLOCKSUNFLOWERSTEM() {

    setTexture("res://items/blocks/foliage/trees/sunflowerTree/stem.png");

    breakTime = 1.0;

    breakParticleID = -1;

    hasCollision = false;

    lightMultiplier = 0.8;

    rotateTextureToGravity = true;

    connectTexturesToMe = false;

    itemToDrop = 59;

    soundMaterial = 2;

    multitile = true;

    isTransparent = true;

}


BLOCKSUNFLOWERSTEM::~BLOCKSUNFLOWERSTEM() {
}


Dictionary BLOCKSUNFLOWERSTEM::onTick(int x, int y, PLANETDATA *planet, int dir){
    
    Dictionary changes = {};

    Vector2i BREAK = Vector2i(Vector2(0,1).rotated(acos(0.0)*dir));
    int tileBelow = planet->getTileData(BREAK.x + x,BREAK.y + y);

    if ( !lookup->hasCollision(tileBelow) && tileBelow != 56){
        changes[Vector2i(x,y)] = -1;

    }

    return changes;

}

Dictionary BLOCKSUNFLOWERSTEM::onBreak(int x, int y, PLANETDATA *planet, int dir){

    Dictionary changes = {};

    Vector2i newPos =  Vector2i(x,y) - Vector2i( Vector2(0,1).rotated(acos(0.0)*dir) );
    int tileAbove = planet->getTileData(newPos.x,newPos.y);

    Vector2i R = Vector2i(Vector2(1,0).rotated(acos(0.0)*dir));
    int tileRIGHT = planet->getTileData(R.x + x,R.y + y);
    if ( tileRIGHT == 58 ){ changes[Vector2i(R.x + x,R.y + y)] = -1; }

    Vector2i L = Vector2i(Vector2(-1,0).rotated(acos(0.0)*dir));
    int tileLEFT = planet->getTileData(L.x + x,L.y + y);
    if ( tileLEFT == 58 ){ changes[Vector2i(L.x + x,L.y + y)] = -1; }

    if (tileAbove != 56){

        for (int xx = 0; xx < 3; xx++){
            for (int yy = 0; yy < 3; yy++){

                Vector2 r = Vector2(xx-1,yy-3).rotated( acos(0.0)*dir );
                Vector2i scrapPos =  Vector2i( r.round() ) + Vector2i(x,y);
                int tile = planet->getTileData(scrapPos.x,scrapPos.y);
                if (tile == 57){

                    changes[scrapPos] = -1;
                }
        
        
            }
        }

    }

   
    return changes;

}