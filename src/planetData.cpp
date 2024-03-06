#include "planetData.h"
#include <godot_cpp/core/class_db.hpp>
#include <algorithm>
#include <memory>

#include <godot_cpp/classes/node2d.hpp>

using namespace godot;

void PLANETDATA::_bind_methods() {
    ClassDB::bind_method(D_METHOD("createEmptyArrays","size"), &PLANETDATA::createEmptyArrays);
   
    ClassDB::bind_method(D_METHOD("getTileData","x","y"), &PLANETDATA::getTileData);
    ClassDB::bind_method(D_METHOD("setTileData","x","y","newValue"), &PLANETDATA::setTileData);

    ClassDB::bind_method(D_METHOD("getBGData","x","y"), &PLANETDATA::getBGData);
    ClassDB::bind_method(D_METHOD("setBGData","x","y","newValue"), &PLANETDATA::setBGData);

    ClassDB::bind_method(D_METHOD("getLightData","x","y"), &PLANETDATA::getLightData);
    ClassDB::bind_method(D_METHOD("setLightData","x","y","newValue"), &PLANETDATA::setLightData);

    ClassDB::bind_method(D_METHOD("getTimeData","x","y"), &PLANETDATA::getTimeData);
    ClassDB::bind_method(D_METHOD("setTimeData","x","y","newValue"), &PLANETDATA::setTimeData);

    ClassDB::bind_method(D_METHOD("setGlobalTick","tick"), &PLANETDATA::setGlobalTick);
    ClassDB::bind_method(D_METHOD("getGlobalTick"), &PLANETDATA::getGlobalTick);

    ClassDB::bind_method(D_METHOD("getPositionLookup","x","y"), &PLANETDATA::getPositionLookup);
    ClassDB::bind_method(D_METHOD("setPositionLookup","x","y","newValue"), &PLANETDATA::setPositionLookup);

    ClassDB::bind_method(D_METHOD("createAllChunks","chunkScene","chunkContainer","sizeInChunks"), &PLANETDATA::createAllChunks);

    ClassDB::bind_method(D_METHOD("findSpawnPosition"), &PLANETDATA::findSpawnPosition);
}

void PLANETDATA::createEmptyArrays(int size) {

    int bigSize = size * size;

    tileData = new  int[bigSize];
    bgData = new  int[bigSize];
    lightData = new  double[bigSize];
    timeData = new  int[bigSize];

    positionLookup = new int[bigSize];

    planetSize = size;

    

}

// TILE DATA //
int PLANETDATA::getTileData(int x, int y) {


    if ( x != std::clamp(x,0,planetSize-1) ){
        return 5;
    }
    if ( y != std::clamp(y,0,planetSize-1) ){
        return 5;
    }

    int xyToLarge = (x * planetSize) + y;
    
    int tile = tileData[xyToLarge];
   
    return tile;
}

bool PLANETDATA::setTileData(int x, int y, int newValue) {

    int bigSize = planetSize * planetSize;

    int xyToLarge = (x * planetSize) + y;
    xyToLarge = std::clamp(xyToLarge,0,bigSize-1);

    tileData[xyToLarge] = newValue;
   
    return true;
}

// BACKGROUND TILE DATA //
int PLANETDATA::getBGData(int x, int y) {

    int bigSize = planetSize * planetSize;

    int xyToLarge = (x * planetSize) + y;
    xyToLarge = std::clamp(xyToLarge,0,bigSize-1);
    
    int tile = bgData[xyToLarge];
   
    return tile;
}

bool PLANETDATA::setBGData(int x, int y, int newValue) {

    int bigSize = planetSize * planetSize;

    int xyToLarge = (x * planetSize) + y;
    xyToLarge = std::clamp(xyToLarge,0,bigSize-1);

    bgData[xyToLarge] = newValue;
   
    return true;
}

// LIGHT DATA //
double PLANETDATA::getLightData(int x, int y) {

    if ( x != std::clamp(x,0,planetSize-1) ){
        return 1.0;
    }
    if ( y != std::clamp(y,0,planetSize-1) ){
        return 1.0;
    }

    int xyToLarge = (x * planetSize) + y;
    
    double tile = lightData[xyToLarge];
   
    return tile;
}

bool PLANETDATA::setLightData(int x, int y, double newValue) {

    int bigSize = planetSize * planetSize;

    int xyToLarge = (x * planetSize) + y;
    xyToLarge = std::clamp(xyToLarge,0,bigSize-1);

    lightData[xyToLarge] = newValue;
   
    return true;
}

// TIME DATA //
int PLANETDATA::getTimeData(int x, int y) {

    if ( x != std::clamp(x,0,planetSize-1) ){
        return 0;
    }
    if ( y != std::clamp(y,0,planetSize-1) ){
        return 0;
    }

    int xyToLarge = (x * planetSize) + y;
    
    int tile = timeData[xyToLarge];
   
    return tile;
}

bool PLANETDATA::setTimeData(int x, int y, int newValue) {

    int bigSize = planetSize * planetSize;

    int xyToLarge = (x * planetSize) + y;
    xyToLarge = std::clamp(xyToLarge,0,bigSize-1);

    timeData[xyToLarge] = newValue;
   
    return true;
}

// POSITION LOOKUP //
int PLANETDATA::getPositionLookup(int x, int y) {

    int bigSize = planetSize * planetSize;

    int xyToLarge = (x * planetSize) + y;
    xyToLarge = std::clamp(xyToLarge,0,bigSize-1);
    
    int tile = positionLookup[xyToLarge];
   
    return tile;
}

bool PLANETDATA::setPositionLookup(int x, int y, int newValue) {

    int bigSize = planetSize * planetSize;

    int xyToLarge = (x * planetSize) + y;
    xyToLarge = std::clamp(xyToLarge,0,bigSize-1);

    positionLookup[xyToLarge] = newValue;
   
    return true;
}

// GLOBAL TICK //
void PLANETDATA::setGlobalTick(int tick){
    globalTick = tick;
}

int PLANETDATA::getGlobalTick(){
    return globalTick;
}


PLANETDATA::PLANETDATA() {
	tileData = NULL;
    bgData = NULL;
    lightData = NULL;
    timeData = NULL;
    globalTick = 0;
}

PLANETDATA::~PLANETDATA() {
	
    if (tileData != NULL) {
       
        delete [] tileData;
        
    }

    if (bgData != NULL) {
       
        delete [] bgData;
        
    }

    if (lightData != NULL) {
       
        delete [] lightData;
        
    }

    if (timeData != NULL) {
       
        delete [] timeData;
        
    }

}

Array PLANETDATA::createAllChunks(PackedScene *chunkScene, Node *chunkContainer, int sizeInChunks){
    Array FAGGOT;

    for(int x = 0; x < sizeInChunks; x++){

        Array BALLSEX;

        for(int y = 0; y < sizeInChunks; y++){
            Node2D *STINK = dynamic_cast<Node2D*>(chunkScene->instantiate());
          
           // Vector2 newPos = (Vector2(x,y) * 64) - Vector2(sizeInChunks*32,sizeInChunks*32);
            
            Vector2 newPos = Vector2(x,y);
            STINK->set_position( newPos );
            chunkContainer->add_child( STINK );
            BALLSEX.append(STINK);
        
        }

        FAGGOT.append(BALLSEX);

    }


    return FAGGOT;
}

int PLANETDATA::findSpawnPosition(){
    
    for(int y = 0; y < planetSize; y++){
        int id = getTileData(planetSize/2,y);

        if(id > 1){
            return ((y - 4) * 8) - (planetSize * 4) + 4;
        }

    }

    return 0;
}