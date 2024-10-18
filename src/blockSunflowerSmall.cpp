#include "blockSunflowerSmall.h"
#include "lookupBlock.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKSUNFLOWERSMALL::_bind_methods() {
}

BLOCKSUNFLOWERSMALL::BLOCKSUNFLOWERSMALL() {

    setTexture("res://items/blocks/foliage/trees/sunflowerTree/flowerSmall.png");

    breakTime = 0.0;
    multitile = true;
    rotateTextureToGravity = true;
    hasCollision = false;
    connectTexturesToMe = false;
    lightMultiplier = 0.95;
    itemToDrop = 59;
    breakParticleID = 2;
    isTransparent = true;
    soundMaterial = 5;

}


BLOCKSUNFLOWERSMALL::~BLOCKSUNFLOWERSMALL() {
}

Dictionary BLOCKSUNFLOWERSMALL::onTick(int x, int y, PLANETDATA *planet, int dir){
    Dictionary changes = {};

    Vector2i BREAK = Vector2i(Vector2(0,1).rotated(acos(0.0)*dir));
    int tileBelow = planet->getTileData(BREAK.x + x,BREAK.y + y);

    if ( !lookup->hasCollision(tileBelow) && tileBelow != 59){
        changes[Vector2i(x,y)] = -1;
    }

    if ( planet->getInfoData( x,y ) == 4 || planet->getInfoData( x,y ) == 6 ){

        int size = (std::rand() % 10) + 7;

        for( int i = -1; i < size; i++ ){

            Vector2i rot = Vector2i(Vector2(0,-i).rotated(acos(0.0)*dir));
            changes[Vector2i(x+rot.x,y+rot.y)] = 56;
            planet->setInfoData(x+rot.x,y+rot.y,0);

            if ( std::rand() % 3 == 0 ) {
                int b = (std::rand() % 2) + 1;

                planet->setInfoData(x+rot.x,y+rot.y,b);
                Vector2i pee = Vector2i(Vector2( ( b * 2 ) - 3 ,0).rotated(acos(0.0)*dir));
                changes[Vector2i(x+rot.x+pee.x,y+rot.y+pee.y)] = 58;
                planet->setInfoData(x+rot.x+pee.x,y+rot.y+pee.y,b-1);


            }

            if ( i == size-1 ){
                int gay = 0;
                for(int xx = -1; xx <2; xx++){
                    for(int yy = -1; yy <2; yy++){
                        Vector2i trueCoord = Vector2i(Vector2(xx,yy).rotated(acos(0.0)*dir).round() );
                        Vector2i balls = Vector2i( x+trueCoord.x+rot.x, y+trueCoord.y+rot.y );
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

Dictionary BLOCKSUNFLOWERSMALL::onBreak(int x, int y, PLANETDATA *planet, int dir){

    Dictionary changes = {};

    int multitileInfo = planet->getInfoData(x,y) % 2;

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