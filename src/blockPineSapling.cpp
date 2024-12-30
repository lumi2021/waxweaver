#include "blockPineSapling.h"
#include <godot_cpp/core/class_db.hpp>

#include <godot_cpp/variant/utility_functions.hpp>

#include "lookupBlock.h"

using namespace godot;

void BLOCKPINESAPLING::_bind_methods() {
}

BLOCKPINESAPLING::BLOCKPINESAPLING() {

    setTexture("res://items/blocks/foliage/trees/pineTree/pineSapling.png");

    breakTime = 0.0;

    breakParticleID = -1;

    hasCollision = false;

    lightMultiplier = 1.0;

    rotateTextureToGravity = true;

    connectTexturesToMe = false;

    itemToDrop = 110;

    isTransparent = true;
    soundMaterial = 5;

}


BLOCKPINESAPLING::~BLOCKPINESAPLING() {
}

Dictionary BLOCKPINESAPLING::onTick(int x, int y, PLANETDATA *planet, int dir){
    Dictionary changes = {};


    int timeAlive = planet->getGlobalTick() - planet->getTimeData(x,y);

    Vector2i BREAK = Vector2i(Vector2(0,1).rotated(acos(0.0)*dir));
    int whatsBelowMe = planet->getTileData(BREAK.x + x,BREAK.y + y);
    if( !lookup->hasCollision(whatsBelowMe) ){
        changes[Vector2i(x,y)] = -1;
        return changes;

    }

    if (timeAlive > 4500){
        int logheight = (std::rand() % 5) + 2;

        changes[Vector2i( x, y )] = 8;
        for( int i = 0; i < logheight; i++ ){ // make tree stem
            Vector2i pos = Vector2i(Vector2(0,-i).rotated(acos(0.0)*dir));
            if ( planet->getTileData(pos.x + x, pos.y + y) < 2 ){ // check for empty space
                changes[Vector2i( pos.x + x, pos.y + y )] = 8; // fill with log
            }
        }


        int tiles[25] = { // tree structure map
         -1, -1, -1,111,111,
         -1,111,111,112,111,
        111,112,112,112,112,
         -1,111,111,112,111,
         -1, -1, -1,111,111,
        };

        int i = 0;
        for( int xx = 0; xx < 5; xx++ ){
            for( int yy = 0; yy < 5; yy++ ){
                
                if (tiles[i] == -1){ 
                    i++;
                    continue; } // skips generation if id is -1

                Vector2 p = Vector2(xx-2,yy - logheight - 4 ).rotated(acos(0.0)*dir);
                Vector2i pos = Vector2i(p.x + x,p.y + y);

                int existingTile = planet->getTileData(pos.x,pos.y);
                
                if ( existingTile < 2 || existingTile == 111 || existingTile == 9 ) { // ensure pos is air or other leaves
                    changes[pos] = tiles[i];
                }

                i++;
            }
        
        }

    }

    return changes;
}