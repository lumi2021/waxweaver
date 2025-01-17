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
        case 3:
            return genetatePond(x,y,planet,dir);
        case 4:
            return generateIglooBase(x,y,planet,dir);
        case 5:
            return generateIglooDoor(x,y,planet,dir);
        case 6:
            return selectRandomUGStructure(x,y,planet,dir);
        case 7:
            return generatePillarTop(x,y,planet,dir);
        case 8:
            return generatePillarMid(x,y,planet,dir);
        case 9:
            return generatePillarBottom(x,y,planet,dir);
        case 10:
            return generateMarbleThing(x,y,planet,dir);


    }

    // change nothing in the event of failure
    Dictionary changes = {};
    return changes;

}

Dictionary BLOCKSTRUCTURE::generateHouse(int worldx, int worldy, PLANETDATA *planet, int dir){
    Dictionary changes = {};

    // remember: vertical strips
    int tiles[35] = {0,0,13,13,22,22,32, 0,0,13,0,0,0,32, 0,0,13,0,0,34,32, 2,2,13,0,0,0,32, 0,0,13,13,22,22,32};
    int bg[35] = {0,0,13,13,13,13,13, 0,0,13,13,13,13,13, 0,0,13,13,21,13,13, 0,0,13,13,13,13,13, 0,0,13,13,13,13,13,};
    
    int i = 0;
    for( int x = 0; x < 5; x++ ){
        for( int y = 0; y < 7; y++ ){
            
            Vector2 p = Vector2(x-2,y-5).rotated(acos(0.0)*dir);

            Vector2i pos = Vector2i(p.x + worldx,p.y + worldy);

            changes[pos] = tiles[i];

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
    32, 32, 32, 32, 32, -1, -1, -1, -1, -1, 
    32,121,120,121, 32, -1, -1, -1, -1, -1, 
    32, 64,120,  0, 32, 32, 32, 32, 32, -1,
    32,  0,  0, 64, 32,  0,123,122, 32, -1, 
    32,  0,  0,  0, 47,  0,  0,122, 32, -1,
    32,121,120,  0, 47,  0, 19, 19, 32, -1,
    32, 64,120,  0, 32,  0,  0,  0, 32, -1, 
    32, 32, 32, 32, 32,  0, 25, 25, 25, 25,
    -1, -1, -1, -1, 32,  0,  0,121, 32, -1,
    -1, -1, -1, -1, 32, 32, 32, 32, 32, -1
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

            if (tiles[i] == 19){ // is chair
                planet->setInfoData(pos.x,pos.y,2);
                if(y==7){
                    planet->setInfoData(pos.x,pos.y,3);
                }
            }

            if (tiles[i] == 122){ // is table
                planet->setInfoData(pos.x,pos.y,0);
                if(x==4){
                    planet->setInfoData(pos.x,pos.y,1);
                }
            }

            if (tiles[i] == 123){ // is flower pot
                planet->setInfoData(pos.x,pos.y, (std::rand() % 4) + 1 ); // select random flower
            }

            if (tiles[i] == 121){ // is book
                planet->setInfoData(pos.x,pos.y, (std::rand() % 8) ); // select random book sprite
            }
        
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

Dictionary BLOCKSTRUCTURE::genetatePond(int worldx, int worldy, PLANETDATA *planet, int dir){
    Dictionary changes = {};

    int tiles[35] = {
    -1,-1,2,-1,-1,
    0,0,-8,2,-1,
    0,0,-8,-8,2,
    0,0,-8,-8,2,
    0,0,-8,-8,2,
    0,0,-8,2,-1,
    -1,-1,2,-1,-1
    };


    int i = 0;
    for( int x = 0; x < 7; x++ ){
        for( int y = 0; y < 5; y++ ){
            
            if (tiles[i] == -1){ 
                i++;
                continue; } // skips generation if id is -1
            
            Vector2 p = Vector2(x-3,y-1).rotated(acos(0.0)*dir);
            Vector2i pos = Vector2i(p.x + worldx,p.y + worldy);

            if (tiles[i] == 2){ // skip if block is already present, otherwise place stone
                if (planet->getTileData(pos.x,pos.y) > 2){ // block already exists
                    i++;
                    continue; 
                }
            }

            if (tiles[i] == -8){ // place air and water
                
                changes[pos] = 0;
                planet->setWaterData(pos.x,pos.y,1.0);


                i++;
                continue; 
                
            }


            changes[pos] = tiles[i];
            i++;
        }
    
    }

    return changes;

}

Dictionary BLOCKSTRUCTURE::generateIglooBase(int worldx, int worldy, PLANETDATA *planet, int dir){
    Dictionary changes = {};

    // remember: vertical strips
    int tiles[70] = {
     -1, -1, -1, -1, -1, 54, -1,
     -1, -1,109,109,109,109,109,
     -1,109,  0,  0,  0,  0,109,
    109,  0,  0,  0,  0,  0,109,
    109,  0,  0,  0,117,117,109,
    109,  0,  0,  0,117,117,109,
    109,  0,  0,  0,  0,  0,109,
     -1,109,  0,  0,  0,  0,109,
     -1, -1,109,109,109,109,109,
     -1, -1, -1, -1, -1, 54, -1,
    };

    int doorside = std::rand() % 2;

    int i = 0;
    int campfiretiles = 0;
    for( int x = 0; x < 10; x++ ){
        for( int y = 0; y < 7; y++ ){
            
            if (tiles[i] == 54){ // is structure for door
                if (doorside == 0){
                    if(x==9){ i++; continue; }
                }

                if (doorside == 1){
                    if(x==0){ i++; continue; }
                }

            
            }



            if (tiles[i] == -1){ 
                i++;
                continue; } // skips generation if id is -1

            Vector2 p = Vector2(x-4,y-3).rotated(acos(0.0)*dir);
            Vector2i pos = Vector2i(p.x + worldx,p.y + worldy);

            changes[pos] = tiles[i];

            planet->setBGData(pos.x,pos.y,109);
            if (tiles[i] == 54){
                planet->setInfoData(pos.x,pos.y,5);
            }

            if (tiles[i] == 117){ // is campfire, 0 2 1 3

                planet->setInfoData(pos.x,pos.y,campfiretiles);

                campfiretiles = campfiretiles + 2;
                if(campfiretiles == 4){ campfiretiles = campfiretiles - 3; }
            }
        
            i++;
        }
    
    }

    return changes;

}


Dictionary BLOCKSTRUCTURE::generateIglooDoor(int worldx, int worldy, PLANETDATA *planet, int dir){
    Dictionary changes = {};

    // remember: vertical strips
    int tiles[12] = {
    109,  0,  0,109,
    109,  0,  0,109,
    109,  0,  0,109,
    };

    int i = 0;
    for( int x = 0; x < 3; x++ ){
        for( int y = 0; y < 4; y++ ){
            
            if (tiles[i] == -1){ 
                i++;
                continue; } // skips generation if id is -1

            Vector2 p = Vector2(x-1,y-2).rotated(acos(0.0)*dir);
            Vector2i pos = Vector2i(p.x + worldx,p.y + worldy);

            changes[pos] = tiles[i];

            planet->setBGData(pos.x,pos.y,109);
        
            i++;
        }
    
    }

    return changes;

}

Dictionary BLOCKSTRUCTURE::selectRandomUGStructure(int worldx, int worldy, PLANETDATA *planet, int dir){
    int r = std::rand() % 3;

    switch(r){
        case 0:
            return generateUGDecorHouse(worldx,worldy,planet,dir);
        case 1:
            return generateUGDecorWell(worldx,worldy,planet,dir);
        case 2:
            return generateUGDecorWindchime(worldx,worldy,planet,dir);
    }
    Dictionary changes = {};
    return changes;

}

Dictionary BLOCKSTRUCTURE::generateUGDecorHouse(int worldx, int worldy, PLANETDATA *planet, int dir){
    Dictionary changes = {};

    // remember: vertical strips
    int tiles[49] = {
    32, 32, 32, 32, 32, 32, 32,
    -1, 13, -1, -1, -1, 13, 32,
    -1, 13,124,125, -1, 13, 32,
    -1, -1, -1, -1,  1, 13, 32,
    -1, -1, -1, -1, 34, 13, 32,
    -1, -1, -1, -1, -1, 13, 32,
    -1, -1, -1, 32, 32, 32, 32,
    };

    int i = 0;
    for( int x = 0; x < 7; x++ ){
        for( int y = 0; y < 7; y++ ){
            
            if (tiles[i] == -1){ 
                i++;
                continue; } // skips generation if id is -1

            Vector2 p = Vector2(x-3,y-4).rotated(acos(0.0)*dir);
            Vector2i pos = Vector2i(p.x + worldx,p.y + worldy);

            

            if (planet->getTileData(pos.x,pos.y) < 2 || planet->getTileData(pos.x,pos.y) == 54){
                changes[pos] = tiles[i];
            }

        
            i++;
        }
    
    }

    return changes;

}

Dictionary BLOCKSTRUCTURE::generateUGDecorWell(int worldx, int worldy, PLANETDATA *planet, int dir){
    Dictionary changes = {};

    // remember: vertical strips
    int tiles[60] = {
    -1, 32, -1, -1, -1, -1, 32, 32, 32, -1,
    32, 32, 13, 13, 13, 32, 32, 32, 32, 32,
    32, 32,  0,  0,  0,  0,  8,  8,  8, 32,
    32, 32,  0,  0,  0,  0,  8,  8,  8, 32,
    32, 32, 13, 13, 13, 32, 32, 32, 32, 32,
    -1, 32, -1, -1, -1, -1, 32, 32, 32, -1,
    };

    int i = 0;
    for( int x = 0; x < 6; x++ ){
        for( int y = 0; y < 10; y++ ){
            
            if (tiles[i] == -1){ 
                i++;
                continue; } // skips generation if id is -1

            Vector2 p = Vector2(x-2,y-5).rotated(acos(0.0)*dir);
            Vector2i pos = Vector2i(p.x + worldx,p.y + worldy);

            if( tiles[i] == 8 ){
                planet->setWaterData(pos.x,pos.y,1.0);
                changes[pos] = 0;
                i++;
                continue;
            }

            if( tiles[i] == 13 ){
                planet->setBGData(pos.x,pos.y,13);
                i++;
                continue;
            }
            
            changes[pos] = tiles[i];

        
            i++;
        }
    
    }

    return changes;

}

Dictionary BLOCKSTRUCTURE::generateUGDecorWindchime(int worldx, int worldy, PLANETDATA *planet, int dir){
    Dictionary changes = {};

    // remember: vertical strips
    int tiles[40] = {
    -1, -1, -1, -1, -1, -1, -1, 32,
    -1, 32, -1, -1, -1, -1, 32, 32,
    32, 32,124,127,127,  0, 32, 32,
    -1, 32, -1, -1, -1, -1, 32, 32,
    -1, -1, -1, -1, -1, -1, -1, 32,
    };

    int i = 0;
    for( int x = 0; x < 5; x++ ){
        for( int y = 0; y < 8; y++ ){
            
            

            Vector2 p = Vector2(x-2,y-6).rotated(acos(0.0)*dir);
            Vector2i pos = Vector2i(p.x + worldx,p.y + worldy);

            if(x == 2){
                planet->setBGData(pos.x,pos.y,13);
            }
            
            if (tiles[i] == -1){ 
                i++;
                continue;
            } // skips generation if id is -1

            changes[pos] = tiles[i];
            if (tiles[i] == 127){ // placing windchime
                planet->setInfoData(pos.x,pos.y,0);
                if(i == 20){
                    planet->setInfoData(pos.x,pos.y,1);
                }
            }

        
            i++;
        }
    
    }

    return changes;

}

Dictionary BLOCKSTRUCTURE::generatePillarTop(int worldx, int worldy, PLANETDATA *planet, int dir){
    Dictionary changes = {};

    // remember: vertical strips
    int tiles[18] = {
    32, 32, -1,
    32, 32, 32,
    32, 32, 54,
    32, 32, 32,
    32, 32, 32,
    32, 32, -1,
    };

    int i = 0;
    for( int x = 0; x < 6; x++ ){
        for( int y = 0; y < 3; y++ ){
            
            if (tiles[i] == -1){ 
                i++;
                continue; } // skips generation if id is -1

            Vector2 p = Vector2(x-2,y-2).rotated(acos(0.0)*dir);
            Vector2i pos = Vector2i(p.x + worldx,p.y + worldy);

            changes[pos] = tiles[i];

            if (tiles[i] == 54){
                planet->setInfoData(pos.x,pos.y,8); // set to pillar mid
            }

            i++;
        }
    
    }

    return changes;

}

Dictionary BLOCKSTRUCTURE::generatePillarMid(int worldx, int worldy, PLANETDATA *planet, int dir){
    Dictionary changes = {};

    // remember: vertical strips
    int tiles[6] = {
    32, 32, 54,
    32, 32, 32,
    };

    int i = 0;
    for( int x = 0; x < 2; x++ ){
        for( int y = 0; y < 3; y++ ){
            
            if (tiles[i] == -1){ 
                i++;
                continue; } // skips generation if id is -1

            Vector2 p = Vector2(x,y).rotated(acos(0.0)*dir);
            Vector2i pos = Vector2i(p.x + worldx,p.y + worldy);

            changes[pos] = tiles[i];

            if (tiles[i] == 54){
                if(planet->getPositionLookup(pos.x,pos.y) != dir){
                    changes[pos] = 0; // if position goes over corner, cancel pillar generation
                    i++;
                    continue;
                }

                if(planet->getTileData(pos.x,pos.y) >= 2){ // collided with ground
                    planet->setInfoData(pos.x,pos.y,9); // set info to pillar base
                    i++;
                    continue;
                }
                planet->setInfoData(pos.x,pos.y,8); // set to pillar mid
            }

            i++;
        }
    
    }

    return changes;

}

Dictionary BLOCKSTRUCTURE::generatePillarBottom(int worldx, int worldy, PLANETDATA *planet, int dir){
    Dictionary changes = {};

    // remember: vertical strips
    int tiles[18] = {
    -1, 32, 32,
    32, 32, 32,
    32, 32, 32,
    32, 32, 32,
    32, 32, 32,
    -1, 32, 32,
    };

    int i = 0;
    for( int x = 0; x < 6; x++ ){
        for( int y = 0; y < 3; y++ ){
            
            if (tiles[i] == -1){ 
                i++;
                continue; } // skips generation if id is -1

            Vector2 p = Vector2(x-2,y).rotated(acos(0.0)*dir);
            Vector2i pos = Vector2i(p.x + worldx,p.y + worldy);

            changes[pos] = tiles[i];

            i++;
        }
    
    }

    return changes;

}

Dictionary BLOCKSTRUCTURE::generateMarbleThing(int worldx, int worldy, PLANETDATA *planet, int dir){
    Dictionary changes = {};

    // remember: vertical strips
    int tiles[25] = {
     -1, -1, -1,115, -1,
    116,116,116,115,115,
     -1, -1, -1,115,115,
     -1,116,116,115,115,
     -1, -1, -1,115, -1,
    };

    int i = 0;
    for( int x = 0; x < 5; x++ ){
        for( int y = 0; y < 5; y++ ){
            
            if (tiles[i] == -1){ 
                i++;
                continue; } // skips generation if id is -1

            Vector2 p = Vector2(x-2,y-3).rotated(acos(0.0)*dir);
            Vector2i pos = Vector2i(p.x + worldx,p.y + worldy);
            
            int b = planet->getTileData(pos.x,pos.y);

            if (b < 2 || b == 54 || b == 119){
                changes[pos] = tiles[i];
            }
            i++;
        }
    
    }

    return changes;

}