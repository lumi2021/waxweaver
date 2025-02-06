#include "blockPinkTreeSapling.h"
#include <godot_cpp/core/class_db.hpp>

#include <godot_cpp/variant/utility_functions.hpp>

#include "lookupBlock.h"

using namespace godot;

void BLOCKPINKTREESAPLING::_bind_methods() {
}

BLOCKPINKTREESAPLING::BLOCKPINKTREESAPLING() {

    setTexture("res://items/blocks/foliage/trees/pinkTree/sapling.png");

    breakTime = 0.0;

    breakParticleID = -1;

    hasCollision = false;

    lightMultiplier = 1.0;

    rotateTextureToGravity = true;

    connectTexturesToMe = false;

    itemToDrop = 135;

    isTransparent = true;
    soundMaterial = 5;

}


BLOCKPINKTREESAPLING::~BLOCKPINKTREESAPLING() {
}

Dictionary BLOCKPINKTREESAPLING::onTick(int x, int y, PLANETDATA *planet, int dir){
    Dictionary changes = {};


    int timeAlive = planet->getGlobalTick() - planet->getTimeData(x,y);

    Vector2i BREAK = Vector2i(Vector2(0,1).rotated(acos(0.0)*dir));
    int whatsBelowMe = planet->getTileData(BREAK.x + x,BREAK.y + y);
    if( !lookup->hasCollision(whatsBelowMe) ){
        changes[Vector2i(x,y)] = -1;
        return changes;

    }

    if (timeAlive > 4500){
        int logheight = (std::rand() % 8) + 2;

        changes[Vector2i( x, y )] = 132;
        planet->setInfoData(x,y,0);
        for( int i = 0; i < logheight; i++ ){ // make tree stem
            Vector2i pos = Vector2i(Vector2(0,-i).rotated(acos(0.0)*dir));
            if ( planet->getTileData(pos.x + x, pos.y + y) < 2 ){ // check for empty space
                changes[Vector2i( pos.x + x, pos.y + y )] = 132; // fill with log
                planet->setInfoData(pos.x + x, pos.y + y,1);
                if( i >= logheight - 1 ){
                    planet->setInfoData(pos.x + x, pos.y + y,2);
                }
            }
        }


        int tiles[6] = { // tree structure map
        133,133,
        133,133,
        133,133,
        };

        int i = 0;
        for( int xx = 0; xx < 3; xx++ ){
            for( int yy = 0; yy < 2; yy++ ){
                
                if (tiles[i] == -1){ 
                    i++;
                    continue; } // skips generation if id is -1

                Vector2 p = Vector2(xx-1,yy - logheight - 1 ).rotated(acos(0.0)*dir);
                Vector2i pos = Vector2i(p.x + x,p.y + y);

                int existingTile = planet->getTileData(pos.x,pos.y);
                
                if ( existingTile < 2 || existingTile == 133 ) { // ensure pos is air or other leaves
                    changes[pos] = tiles[i];
                    if (std::rand() % 3 == 0){ changes[pos] = 134; }
                }

                i++;
            }
        
        }

    }

    return changes;
}