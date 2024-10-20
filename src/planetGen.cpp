#include "planetGen.h"
#include <godot_cpp/core/class_db.hpp>


using namespace godot;

void PLANETGEN::_bind_methods() {
    ClassDB::bind_method(D_METHOD("generateForestPlanet","DATAC"), &PLANETGEN::generateForestPlanet);
    ClassDB::bind_method(D_METHOD("generateLunarPlanet","DATAC"), &PLANETGEN::generateLunarPlanet);
    ClassDB::bind_method(D_METHOD("generateSunPlanet","DATAC"), &PLANETGEN::generateSunPlanet);
    ClassDB::bind_method(D_METHOD("generateAridPlanet","DATAC"), &PLANETGEN::generateAridPlanet);
}

PLANETGEN::PLANETGEN() {
    lookup = memnew(LOOKUPBLOCK);
}

PLANETGEN::~PLANETGEN() {
	// Add your cleanup here.
}


/////////////////// FOREST GENERATION /////////////////

void PLANETGEN::generateForestPlanet(PLANETDATA *planet,FastNoiseLite *noise){
    int planetSize = planet->planetSize;

    int lastSpawnedTree = 16;
    int baseSurface = std::max( planetSize / 4, (planetSize/2) - 128 );
    int skySize = (planetSize - (baseSurface * 2)) / 2;

    // first pass
    // basic terrain, lakes and oceans
    for(int x = 0; x < planetSize; x++){
        for(int y = 0; y < planetSize; y++){

            int quad = planet->getPositionLookup(x,y);
            int side = Vector2(x,y).rotated(acos(0.0) * quad).x;
            double dis = getBlockDistance(x,y,planet);
            double surface = (noise->get_noise_1d(side*2.0) * 8.0)  +  baseSurface;

            if (dis <= surface){
                planet->setTileData(x,y,2);
                planet->setBGData(x,y,2);
            }
            else if (dis <= surface + 4){
                planet->setTileData(x,y,3);
                planet->setBGData(x,y,3);
            }
            else if (dis <= surface + 5){
                planet->setTileData(x,y,4);
                //planet->setBGData(x,y,0);
            }

            double r = (std::abs(dis - (baseSurface * 0.6 ) ) ) / (baseSurface * 0.75);

            int caveSize = 2;
            double n = noise->get_noise_2d(x * caveSize, y * caveSize) + r;
            if ( n < 0.25 && n > -0.25 ){
                planet->setTileData(x,y, airOrCaveAir(x,y,planet) );
            }

            // lake / ocean stuff
            double lakeSurface = (noise->get_noise_1d((2000 + ( planetSize * quad * 0.75)) + (side*0.75)) * 64.0)  + baseSurface;
            if (dis >= lakeSurface && dis <= surface + 6){
                
                planet->setTileData(x,y, 4 );
                //planet->setBGData(x,y,3);

                int poop = dis - (baseSurface - 15);
                poop = poop / 2;
                if (poop < 3){
                    poop = 3; // for some reason std::min won't work despite std::max working just fine 
                }

                if ( dis <= baseSurface + 3 && dis >= lakeSurface + poop) {
                    planet->setTileData(x,y, 14 );
                    planet->setBGData(x,y,3);
                }
                
                if (dis >= lakeSurface + 8){
                    planet->setTileData(x,y, airOrCaveAir(x,y,planet) );
                    planet->setBGData(x,y,0);
                    if ( dis <= baseSurface + 1) {
                        planet->setWaterData(x,y,1.0);
                    }else if(dis <= baseSurface + 2){
                        planet->setWaterData(x,y,0.7);
                    }

                }
            
            }

            if (dis <= 3){
                planet->setTileData(x,y,5);
                planet->setBGData(x,y,5);
            }
        }
    }


    // second pass
    // foliage and ores and chests
    for(int x = 0; x < planetSize; x++){
        for(int y = 0; y < planetSize; y++){

            int quad = planet->getPositionLookup(x,y);
            int side = Vector2(x,y).rotated(acos(0.0) * quad).x;
            int baseSurface = std::max( planetSize / 4, (planetSize/2) - 128 );
            double dis = getBlockDistance(x,y,planet);

            if (planet->getTileData(x,y) == 4){
                Vector2i up = Vector2i( Vector2(0,-1).rotated(acos(0.0)*quad) );
                if( planet->getTileData(x+up.x,y+up.y) == 0 ){
                    
                    // valid spot for foliage
                    int r = std::rand();
                    if(r % 4 == 0){
                        planet->setTileData(x+up.x,y+up.y,17); // spawn grass
                    }

                    if(r % 32 == 0){
                        planet->setTileData(x+up.x,y+up.y,26); // spawn lily
                    }


                    if(r % 10 == 0){
                        planet->setTileData(x+up.x,y+up.y,7);
                        planet->setTimeData(x+up.x,y+up.y,-16000); // spawn tree sapling
                    }

                    if(std::rand() % 64 == 0){
                        planet->setTileData(x+up.x,y+up.y,38); // spawn natural potato
                        planet->setInfoData(x+up.x,y+up.y,4);
                    }

                    if (quad % 2 != 0){ // spawns only on left and right side of planet
                        if(std::rand() % 70 == 0){
                            planet->setTileData(x+up.x,y+up.y,54); // spawn house structure
                            planet->setInfoData(x+up.x,y+up.y,0);
                        }
                    }

                    if ( quad == 2 ){
                        if(std::rand() % 4 == 0){

                            int roll = (std::rand() % 2) * 2;
                            int upper = up.y * 2;

                            if(std::rand() % 16 == 0){ roll = roll + 4; }

                            planet->setTileData(x+up.x,y+up.y,59); // spawn sunflower
                            planet->setInfoData(x+up.x,y+up.y,1 + roll);
                            planet->setTileData(x+up.x,y+upper,59);
                            planet->setInfoData(x+up.x,y+upper,roll);
                        }
                    }

                }

            }

            // ores
            if(dis < baseSurface - 16){

                
                if( dis < 48 ) {

                    if(std::rand() % 380 == 0){
                        generateOre(planet,x,y,27,2,5); // generate iron
                    }

                }

                if( dis > 64 ) {
                    if(std::rand() % 300 == 0){
                        generateOre(planet,x,y,18,2,5); // generate copper
                    }
                }

                if(std::rand() % 400 == 0){
                    generateOre(planet,x,y,24,2,3); // generate gold
                }

                if(std::rand() % 500 == 0){
                    generateOre(planet,x,y,28,2,10); // generate gravel
                }

                if (planet->getTileData(x,y) == 1){ // cave air

                    Vector2i up = Vector2i( Vector2(0,-1).rotated(acos(0.0)*quad) ) + Vector2i(x,y) ;
                    if( planet->getTileData(up.x,up.y) == 2 ){ // found ceiling
                        if(std::rand() % 3 == 0){
                            planet->setTileData(x,y,52); // spawn stalactite
                            planet->setInfoData(x,y, std::rand() % 2 );

                        }else if(std::rand() % 300 == 0){
                            planet->setTileData(x,y,54);
                            planet->setInfoData(x,y, 1 ); // generate cavern house

                        }

                        

                    }


                    Vector2i down = Vector2i( Vector2(0,1).rotated(acos(0.0)*quad) ) + Vector2i(x,y) ;
                    if( planet->getTileData(down.x,down.y) == 2 ){
                        // found suitable ground underground
                        if(std::rand() % 280 == 0){
                            planet->setTileData(x,y,34); // spawn loot chest
                        }

                    }
                    

                }


            }


        }
    }

    // end big loops, spawn structure?

    int randX = (std::rand() % (baseSurface * 2)) + skySize; // finds random position underground
    int randY = (std::rand() % (baseSurface * 2)) + skySize;
    
    //generateBox(planet,randX,randY,5,5,13,13);
    generateLadderPath(planet,randX,randY, planet->getPositionLookup(randX,randY) );

    // generate boss platform
    int h = (((std::rand() % 200) + 64) * ((( std::rand() % 2 ) * 2) - 1)) + 384;
    int v = (noise->get_noise_1d(h*2.0) * 8.0) + (baseSurface/2) - 4;

    // create rectangle
    for( int x = 0; x < 8; x++ ){
        for( int y = 0; y < 8; y++ ){
            planet->setTileData(x+h-3,y+v-4,0);
        }
    }

    planet->setTileData(h,v,54);
    planet->setInfoData(h,v,2);

}

/////////////////// MOON LUNAR GENERATION /////////////////

void PLANETGEN::generateLunarPlanet(PLANETDATA *planet,FastNoiseLite *noise){
    int planetSize = planet->planetSize;
    for(int x = 0; x < planetSize; x++){
        for(int y = 0; y < planetSize; y++){

            int quad = planet->getPositionLookup(x,y);
            int side = Vector2(x,y).rotated(acos(0.0) * quad).x;
            double dis = getBlockDistance(x,y,planet);
            double surface = (noise->get_noise_1d(side*4.0) * 12.0)  + (planetSize / 4);

            if (dis <= surface){
                planet->setTileData(x,y,28);
                planet->setBGData(x,y,28);
            }
            if (dis <= 3){
                planet->setTileData(x,y,5);
                planet->setBGData(x,y,5);
            }
        }
    }
}

/////////////////// SUN GENERATION /////////////////

void PLANETGEN::generateSunPlanet(PLANETDATA *planet,FastNoiseLite *noise){
    int planetSize = planet->planetSize;
    for(int x = 0; x < planetSize; x++){
        for(int y = 0; y < planetSize; y++){
            
            double dis = getBlockDistance(x,y,planet);
            double surface = (planetSize / 4);

            if (dis <= surface){
                planet->setTileData(x,y,6);
                planet->setBGData(x,y,0);
            }
        }
    }
}

/////////////////// ARID GENERATION /////////////////

void PLANETGEN::generateAridPlanet(PLANETDATA *planet,FastNoiseLite *noise){
    int planetSize = planet->planetSize;

    int baseSurface = std::max( planetSize / 4, (planetSize/2) - 128 );

    for(int x = 0; x < planetSize; x++){
        for(int y = 0; y < planetSize; y++){

            int quad = planet->getPositionLookup(x,y);
            int side = Vector2(x,y).rotated(acos(0.0) * quad).x;
            double dis = getBlockDistance(x,y,planet);
            double surface = (noise->get_noise_1d(side*2.0) * 8.0)  +  baseSurface;

            if (dis <= surface){
                planet->setTileData(x,y,2); // remember to add sandstone in here eventually
                planet->setBGData(x,y,2);
            }else if (dis <= surface + 4){ 
                planet->setTileData(x,y,14);
                planet->setBGData(x,y,14);
            }
            if (dis <= 3){ // core
                planet->setTileData(x,y,5);
                planet->setBGData(x,y,5);
            }
        }
    }
}

//////////////////////// MATH /////////////////////////////////

double PLANETGEN::getBlockDistance(int x, int y, PLANETDATA *planet){
    int planetSize = planet->planetSize;
    int quad = planet->getPositionLookup(x,y);
    Vector2 newPos = Vector2(x - (planetSize / 2) + 0.5, y - (planetSize / 2) + 0.5 ) ;
    newPos = newPos.rotated(acos(0.0) * -quad);


    return -newPos.y;
}

int PLANETGEN::airOrCaveAir(int x,int y, PLANETDATA *planet){
    int planetSize = planet->planetSize;
    int surface = std::max( planetSize / 4, (planetSize/2) - 128 );
    int b = getBlockDistance(x, y, planet) <= surface - 2;
    return b;
}

void PLANETGEN::generateOre(PLANETDATA *planet,int x,int y,int oreID,int replaceID,int cycles){
    if( planet->getTileData(x,y) != replaceID ){
        return;
    }

    // set original ore
    planet->setTileData(x,y,oreID);

    Vector2i offset = Vector2i(0,0);

    for(int c = 0; c < cycles; c++){
        // run through cycles

        offset = offset + Vector2i( Vector2(1,1).rotated( acos(0.0) * (std::rand() % 4) ) );


        for(int d = 0; d < 4; d++){

            Vector2i coolerOffset = Vector2i( Vector2(1,0).rotated( acos(0.0)*d ) );
            Vector2i pos = offset + Vector2i(x,y) + coolerOffset;

            if( planet->getTileData(pos.x,pos.y) == replaceID ){
                planet->setTileData(pos.x,pos.y,oreID);
            }


        }

        
    
    }

}

void PLANETGEN::generateBox(PLANETDATA *planet,int x, int y, int wallID, int bgID){


    

    for (int xx = 0; xx < 5; xx++){
        for (int yy = 0; yy < 5; yy++){

            Vector2i p = Vector2i( x + xx, y + yy );

            planet->setBGData(p.x,p.y,bgID);

            if (xx == 0 || yy == 0 || xx == 4 || yy == 4){
                planet->setTileData(p.x,p.y,wallID);
            } else {
                planet->setTileData(p.x,p.y,airOrCaveAir(p.x,p.y,planet));
            }

        }

    }

}

void PLANETGEN::generateLadderPath(PLANETDATA *planet,int x, int y, int dir){
    int length = (std::rand() % 128) + 64;

    for (int i = 0; i < length; i++){
        Vector2i pos = Vector2i( Vector2(0,i).rotated( acos(0.0) * dir ) );
        Vector2i L = Vector2i( Vector2(-1,0).rotated( acos(0.0) * dir ) );
        Vector2i R = Vector2i( Vector2(1,0).rotated( acos(0.0) * dir ) );

        if (planet->getTileData( x + pos.x, y + pos.y ) == 5 ){
            continue; // continue if trying to delete core
        }

        planet->setTileData( x + pos.x + L.x, y + pos.y + L.y, 1 );
        planet->setTileData( x + pos.x + R.x, y + pos.y + R.y, 1 );

        if ( dir % 2 == planet->getPositionLookup( x + pos.x, y + pos.y ) % 2 ){

            planet->setTileData( x + pos.x, y + pos.y, 25 );
        }else{
            planet->setTileData( x + pos.x, y + pos.y, 1 );
        }


    }

}