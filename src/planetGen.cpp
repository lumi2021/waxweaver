#include "planetGen.h"
#include <godot_cpp/core/class_db.hpp>


using namespace godot;

void PLANETGEN::_bind_methods() {
    ClassDB::bind_method(D_METHOD("generateForestPlanet","DATAC"), &PLANETGEN::generateForestPlanet);
    ClassDB::bind_method(D_METHOD("generateLunarPlanet","DATAC"), &PLANETGEN::generateLunarPlanet);
    ClassDB::bind_method(D_METHOD("generateSunPlanet","DATAC"), &PLANETGEN::generateSunPlanet);
}

PLANETGEN::PLANETGEN() {
}

PLANETGEN::~PLANETGEN() {
	// Add your cleanup here.
}


/////////////////// FOREST GENERATION /////////////////

void PLANETGEN::generateForestPlanet(PLANETDATA *planet,FastNoiseLite *noise){
    int planetSize = planet->planetSize;
    for(int x = 0; x < planetSize; x++){
        for(int y = 0; y < planetSize; y++){

            int quad = planet->getPositionLookup(x,y);
            int side = Vector2(x,y).rotated(acos(0.0) * quad).x;
            double dis = getBlockDistance(x,y,planet);
            double surface = (noise->get_noise_1d(side*2.0) * 4.0)  + (planetSize / 4);

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
                planet->setBGData(x,y,3);
            }
            if (dis <= 3){
                planet->setTileData(x,y,5);
                planet->setBGData(x,y,5);
            }
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
            double surface = (noise->get_noise_1d(side*2.0) * 16.0)  + (planetSize / 4);

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