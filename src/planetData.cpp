#include "planetData.h"
#include <godot_cpp/core/class_db.hpp>
#include <algorithm>
#include <memory>

using namespace godot;

void PLANETDATA::_bind_methods() {
    ClassDB::bind_method(D_METHOD("createEmptyArrays","size"), &PLANETDATA::createEmptyArrays);
   
    ClassDB::bind_method(D_METHOD("getTileData","x","y"), &PLANETDATA::getTileData);
    ClassDB::bind_method(D_METHOD("setTileData","x","y","newValue"), &PLANETDATA::setTileData);

    ClassDB::bind_method(D_METHOD("getBGData","x","y"), &PLANETDATA::getBGData);
    ClassDB::bind_method(D_METHOD("setBGData","x","y","newValue"), &PLANETDATA::setBGData);

    ClassDB::bind_method(D_METHOD("getLightData","x","y"), &PLANETDATA::getLightData);
    ClassDB::bind_method(D_METHOD("setLightData","x","y","newValue"), &PLANETDATA::setLightData);

    ClassDB::bind_method(D_METHOD("getPositionLookup","x","y"), &PLANETDATA::getPositionLookup);
    ClassDB::bind_method(D_METHOD("setPositionLookup","x","y","newValue"), &PLANETDATA::setPositionLookup);
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

    int bigSize = planetSize * planetSize;

    int xyToLarge = (x * planetSize) + y;
    xyToLarge = std::clamp(xyToLarge,0,bigSize-1);
    
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

    int bigSize = planetSize * planetSize;

    int xyToLarge = (x * planetSize) + y;
    xyToLarge = std::clamp(xyToLarge,0,bigSize-1);
    
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



PLANETDATA::PLANETDATA() {
	tileData = NULL;
    bgData = NULL;
    lightData = NULL;
    timeData = NULL;
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
