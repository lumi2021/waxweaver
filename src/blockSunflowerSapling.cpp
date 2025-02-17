#include "blockSunflowerSapling.h"
#include <godot_cpp/core/class_db.hpp>

#include <godot_cpp/variant/utility_functions.hpp>

#include "lookupBlock.h"

using namespace godot;

void BLOCKSUNFLOWERSAPLING::_bind_methods() {
}

BLOCKSUNFLOWERSAPLING::BLOCKSUNFLOWERSAPLING() {

    setTexture("res://items/blocks/foliage/trees/sunflowerTree/sunflowerSapling.png");

    breakTime = 0.0;

    breakParticleID = 8;

    hasCollision = false;

    lightMultiplier = 1.0;

    rotateTextureToGravity = true;

    connectTexturesToMe = false;

    itemToDrop = 60;

    isTransparent = true;
    soundMaterial = 5;

}


BLOCKSUNFLOWERSAPLING::~BLOCKSUNFLOWERSAPLING() {
}

Dictionary BLOCKSUNFLOWERSAPLING::onTick(int x, int y, PLANETDATA *planet, int dir){
    Dictionary changes = {};



    int timeAlive = planet->getGlobalTick() - planet->getTimeData(x,y);

    Vector2i BREAK = Vector2i(Vector2(0,1).rotated(acos(0.0)*dir));
    int whatsBelowMe = planet->getTileData(BREAK.x + x,BREAK.y + y);
    if( !lookup->hasCollision(whatsBelowMe) ){
        changes[Vector2i(x,y)] = -1;
        return changes;

    }

    

    if ( timeAlive > 4500 ){

        Dictionary empty = {};

        int r = std::rand() % 10;
        if(r != 0){ return empty; }

        int size = (std::rand() % 10) + 7;

        for( int i = 0; i < size; i++ ){

            Vector2i rot = Vector2i(Vector2(0,-i).rotated(acos(0.0)*dir));
            changes[Vector2i(x+rot.x,y+rot.y)] = 56;
            int p = planet->getTileData(x+rot.x,y+rot.y);

            if (p > 1 && p != 60 && p != 59){ planet->setTimeData(x,y,planet->getGlobalTick()); return empty; } // cancel if stem is blocked

            planet->setInfoData(x+rot.x,y+rot.y,0);

            if ( std::rand() % 3 == 0 ) {
                int b = (std::rand() % 2) + 1;

                planet->setInfoData(x+rot.x,y+rot.y,b);
                Vector2i pee = Vector2i(Vector2( ( b * 2 ) - 3 ,0).rotated(acos(0.0)*dir));

                if (planet->getTileData(x+rot.x+pee.x, y+rot.y+pee.y) < 2){ // dont grow leaf unless there is space, but doesn't cancel everything

                    changes[Vector2i(x+rot.x+pee.x,y+rot.y+pee.y)] = 58;
                    planet->setInfoData(x+rot.x+pee.x,y+rot.y+pee.y,b-1);
                }

            }

            if ( i == size-1 ){
                int gay = 0;
                for(int xx = -1; xx <2; xx++){
                    for(int yy = -1; yy <2; yy++){
                        Vector2i trueCoord = Vector2i(Vector2(xx,yy).rotated(acos(0.0)*dir).round() );
                        Vector2i balls = Vector2i( x+trueCoord.x+rot.x, y+trueCoord.y+rot.y );

                        if (planet->getTileData(balls.x,balls.y) > 1){ planet->setTimeData(x,y,planet->getGlobalTick()); return empty; } // cancel if flowerr is blocked

                        changes[Vector2i(balls.x,balls.y)] = 57;
                        planet->setInfoData(balls.x,balls.y,gay);
                        gay++;
                    }

                }

            }


        }


    }

    return changes;
}