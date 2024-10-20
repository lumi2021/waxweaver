#include "blockStructure.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKSTRUCTURE::_bind_methods() {
}

BLOCKSTRUCTURE::BLOCKSTRUCTURE() {

    setTexture("res://items/blocks/technical/structure.png");

    breakTime = 5.0;
    miningLevel = 1000;

}


BLOCKSTRUCTURE::~BLOCKSTRUCTURE() {
}

Dictionary BLOCKSTRUCTURE::onTick(int x, int y, PLANETDATA *planet, int dir){

    int structureType = planet->getInfoData(x,y); // gets info data to determine structure

    switch(structureType){
        case 0:
            return generateHouse(x,y,planet,dir);
        case 1:
            return generateCavernHouse(x,y,planet,dir);
        case 2:
            return generateBossShipPlatform(x,y,planet,dir);


    }

    // change nothing in the event of failure
    Dictionary changes = {};
    return changes;

}

Dictionary BLOCKSTRUCTURE::generateHouse(int worldx, int worldy, PLANETDATA *planet, int dir){
    Dictionary changes = {};

    // remember: vertical strips
    int tiles[35] = {0,0,13,13,22,22,32, 0,0,13,0,0,0,32, 0,54,13,0,0,34,32, 2,2,13,0,0,0,32, 0,0,13,13,22,22,32};
    int bg[35] = {0,0,13,13,13,13,13, 0,0,13,13,13,13,13, 0,0,13,13,21,13,13, 0,0,13,13,13,13,13, 0,0,13,13,13,13,13,};
    
    int i = 0;
    for( int x = 0; x < 5; x++ ){
        for( int y = 0; y < 7; y++ ){
            
            Vector2 p = Vector2(x-2,y-5).rotated(acos(0.0)*dir);

            Vector2i pos = Vector2i(p.x + worldx,p.y + worldy);

            changes[pos] = tiles[i];
            if (tiles[i] == 54){ // 10% of double story house
                if (std::rand() % 10 != 0){
                    changes[pos] = 0;
                }
            }

            if (tiles[i] == 34){ // only make chest 10% spawn rate
                if (std::rand() % 10 != 0){
                    changes[pos] = 0;
                }
            }

            if (tiles[i] == 22){ // correct door tiles
                if (y == 5){
                    planet->setInfoData(pos.x,pos.y, 1 );
                }
            }

            planet->setBGData(pos.x,pos.y, bg[i] );
            
            i++;
        }

    }
    
    
    return changes;
}

Dictionary BLOCKSTRUCTURE::generateCavernHouse(int worldx, int worldy, PLANETDATA *planet, int dir){
    Dictionary changes = {};

    // remember: vertical strips
    int tiles[100] = {
    32,32,32,32,32,-1,-1,-1,-1,-1, 
    32,0,0,0,32,-1,-1,-1,-1,-1, 
    32,0,0,0,32,32,32,32,32,-1,
    32,0,0,0,32,0,0,0,32,-1, 
    32,0,0,0,47,0,0,0,32,-1,
    32,0,0,0,47,0,0,0,32,-1,
    32,0,0,0,32,0,0,0,32,-1, 
    32,32,32,32,32,0,25,25,25,25,
    -1,-1,-1,-1,32,0,0,0,32,-1,
    -1,-1,-1,-1,32,32,32,32,32,-1
    };

    int i = 0;
    for( int x = 0; x < 10; x++ ){
        for( int y = 0; y < 10; y++ ){
            
            if (tiles[i] == -1){ 
                i++;
                continue; } // skips generation if id is -1

            Vector2 p = Vector2(x-7,y-7).rotated(acos(0.0)*dir);
            Vector2i pos = Vector2i(p.x + worldx,p.y + worldy);

            changes[pos] = tiles[i];

            if (y!=9){ planet->setBGData(pos.x,pos.y,32); }
        
            i++;
        }
    
    }

    return changes;

}

Dictionary BLOCKSTRUCTURE::generateBossShipPlatform(int worldx, int worldy, PLANETDATA *planet, int dir){
    Dictionary changes = {};

    // remember: vertical strips
    int tiles[112] = {
        -1,-1,-1,-1,26,32,32,32,32,32,32,32,32,-1,
        -1,-1,-1,-1,-1,32,32,32,32,32,32,32,32,32,
        -1,-1,-1,26,32,32,32,32,32,32,32,32,32,32,
        -1,63,63,63,32,32,32,32,32,32,32,32,32,32,
        -1,63,63,63,32,32,32,32,32,32,32,32,32,32,
        -1,-1,-1,26,32,32,32,32,32,32,32,32,32,32,
        -1,-1,-1,-1,-1,32,32,32,32,32,32,32,32,32,
        -1,-1,-1,-1,26,32,32,32,32,32,32,32,32,-1,
    };

    int i = 0;
    int pillar = 0;
    for( int x = 0; x < 8; x++ ){
        for( int y = 0; y < 14; y++ ){
            
            if (tiles[i] == -1){ 
                i++;
                continue; } // skips generation if id is -1

            Vector2 p = Vector2(x-3,y-4).rotated(acos(0.0)*dir);
            Vector2i pos = Vector2i(p.x + worldx,p.y + worldy);

            changes[pos] = tiles[i];

            if (tiles[i] == 63){
                planet->setInfoData(pos.x,pos.y,pillar);
                pillar = pillar + 2;
                if (pillar >= 6){
                    pillar = 1;
                }
            }

            i++;
        }
    
    }

    return changes;
}