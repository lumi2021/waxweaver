#include "planetGen.h"
#include <godot_cpp/core/class_db.hpp>


using namespace godot;

void PLANETGEN::_bind_methods() {
    ClassDB::bind_method(D_METHOD("generateForestPlanet","DATAC"), &PLANETGEN::generateForestPlanet);
    ClassDB::bind_method(D_METHOD("generateLunarPlanet","DATAC"), &PLANETGEN::generateLunarPlanet);
    ClassDB::bind_method(D_METHOD("generateSunPlanet","DATAC"), &PLANETGEN::generateSunPlanet);
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
                planet->setBGData(x,y,3);

                if ( dis <= baseSurface + 3 && dis >= lakeSurface + 6) {
                    planet->setTileData(x,y, 14 );
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
    
    for (int x = 0; x < 6; x++){
        for (int y = 0; y < 6; y++){
            planet->setTileData(x + randX,y + randY,30); // remove this
        }
    }

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
                planet->setTileData(x,y,2);
                planet->setBGData(x,y,2);
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