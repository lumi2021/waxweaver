#include "planetData.h"

#include <godot_cpp/core/class_db.hpp>
#include <algorithm>
#include <memory>

#include "lookupBlock.h"

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

    ClassDB::bind_method(D_METHOD("getInfoData","x","y"), &PLANETDATA::getInfoData);
    ClassDB::bind_method(D_METHOD("setInfoData","x","y","newValue"), &PLANETDATA::setInfoData);

    ClassDB::bind_method(D_METHOD("setGlobalTick","tick"), &PLANETDATA::setGlobalTick);
    ClassDB::bind_method(D_METHOD("getGlobalTick"), &PLANETDATA::getGlobalTick);

    ClassDB::bind_method(D_METHOD("getWaterData","x","y"), &PLANETDATA::getWaterData);
    ClassDB::bind_method(D_METHOD("setWaterData","x","y","newValue"), &PLANETDATA::setWaterData);

    ClassDB::bind_method(D_METHOD("getPositionLookup","x","y"), &PLANETDATA::getPositionLookup);
    ClassDB::bind_method(D_METHOD("setPositionLookup","x","y","newValue"), &PLANETDATA::setPositionLookup);

    ClassDB::bind_method(D_METHOD("createAllChunks","chunkScene","chunkContainer","sizeInChunks"), &PLANETDATA::createAllChunks);

    ClassDB::bind_method(D_METHOD("findSpawnPosition"), &PLANETDATA::findSpawnPosition);
    ClassDB::bind_method(D_METHOD("getSaveString"), &PLANETDATA::getSaveString);
    ClassDB::bind_method(D_METHOD("loadFromString","tileString","bgString","infoString","timeString","waterString"), &PLANETDATA::loadFromString);
    ClassDB::bind_method(D_METHOD("findFloor","x","y"), &PLANETDATA::findFloor);
}

void PLANETDATA::createEmptyArrays(int size, Vector2 centerPoint) {

    int bigSize = size * size;

    tileData = new  int[bigSize];
    bgData = new  int[bigSize];
    lightData = new  double[bigSize];
    timeData = new  int[bigSize];
    waterData = new  double[bigSize];
    infoData = new  int[bigSize];

    positionLookup = new int[bigSize];

    planetSize = size;

    for(int x = 0; x < size; x++){
        for(int y = 0; y < size; y++){
            setTileData(x,y,0);
            setBGData(x,y,0);
            setLightData(x,y,0.0);
            setTimeData(x,y,0);
            setWaterData(x,y,0.0);
            setInfoData(x,y,0);
            setPositionLookup(x,y, getBlockPosition(x,y, centerPoint ) );
        
        }
    }



}

// TILE DATA //
int PLANETDATA::getTileData(int x, int y) {


    if ( x != std::clamp(x,0,planetSize-1) ){
        return 0;
    }
    if ( y != std::clamp(y,0,planetSize-1) ){
        return 0;
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
// Water DATA //
double PLANETDATA::getWaterData(int x, int y) {

    if ( x != std::clamp(x,0,planetSize-1) ){
        return 0.0;
    }
    if ( y != std::clamp(y,0,planetSize-1) ){
        return 0.0;
    }

    int xyToLarge = (x * planetSize) + y;
    
    double tile = waterData[xyToLarge];
   
    return tile;
}

bool PLANETDATA::setWaterData(int x, int y, double newValue) {

    if ( x != std::clamp(x,0,planetSize-1) ){
        return false;
    }
    if ( y != std::clamp(y,0,planetSize-1) ){
        return false;
    }

    int bigSize = planetSize * planetSize;

    int xyToLarge = (x * planetSize) + y;

    waterData[xyToLarge] = newValue;
   
    return true;
}

// INFO DATA //
int PLANETDATA::getInfoData(int x, int y) {

    if ( x != std::clamp(x,0,planetSize-1) ){
        return 0;
    }
    if ( y != std::clamp(y,0,planetSize-1) ){
        return 0;
    }

    int xyToLarge = (x * planetSize) + y;
    
    int tile = infoData[xyToLarge];
   
    return tile;
}

bool PLANETDATA::setInfoData(int x, int y, int newValue) {

    int bigSize = planetSize * planetSize;

    int xyToLarge = (x * planetSize) + y;
    xyToLarge = std::clamp(xyToLarge,0,bigSize-1);

    infoData[xyToLarge] = newValue;
   
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
        float water = getWaterData(planetSize/2,y);

        if(id > 1){
            return ((y - 4) * 8) - (planetSize * 4) + 4;
        }
        if(std::abs(water) > 0.5){
            return ((y - 4) * 8) - (planetSize * 4) + 4;
        }

    }

    return 0;
}

int PLANETDATA::getBlockPosition(int x,int y,Vector2 centerPoint){
    Vector2 angle1 = Vector2(1,1);
    Vector2 angle2 = Vector2(-1,1);
    Vector2 newPos = Vector2(x,y) - centerPoint;

    int dot1 = newPos.dot(angle1) >= 0;
    int dot2 = newPos.dot(angle2) > 0;
    dot2 = dot2 * 2;

    Array nuts;
    nuts.append(0);
    nuts.append(1);
    nuts.append(3);
    nuts.append(2);
    
    return nuts[dot1 + dot2];

}

void PLANETDATA::savePlanet(){

    
}

Vector2i PLANETDATA::findFloor(int x, int y, LOOKUPBLOCK *lookup){

    int dir = getPositionLookup(x,y);

    for(int i = 0; i < 50; i++){ // attempt search for fifty tiles

        Vector2i pos = Vector2i( Vector2(0,i).rotated( acos(0.0) * dir ) ) + Vector2i(x,y) ;

        int id = getTileData(pos.x,pos.y);
        
        if (lookup->hasCollision(id)){ // found floor!
            Vector2i pastPos = Vector2i( Vector2(0,i-1).rotated( acos(0.0) * dir ) ) + Vector2i(x,y) ;
            return pastPos;

        }


    }

    return Vector2i(-10,-10);


}

PackedStringArray PLANETDATA::getSaveString(){
    int size = planetSize * planetSize;

    // tiles
    String tiles = "";
    int lastTile = getTileRow(0);
    int tileInRow = 0;

    // bg walls
    String bgs = "";
    int lastBG = getBGRow(0);
    int BGInRow = 0;

    // info multitile stuff
    String infostring = "";
    int lastInfo = getInfoRow(0);
    int InfoInRow = 0;

    // time tick stuff
    String timestring = "";
    int lastTime = getTimeRow(0);
    int TimeInRow = 0;

    // water stuff
    String waterstring = "";
    float lastWater = getWaterRow(0);
    int WaterInRow = 0;


    for(int i = 0; i < size; i++){ // loop through every tile

        // tiles
        int tile = getTileRow(i); // gets tile
        if(lastTile == tile){
            tileInRow++;
        }else{
            tiles += String::num_int64(lastTile) + "x";
            tiles += String::num_int64(tileInRow) + ",";
            tileInRow = 1;
            lastTile = tile;
        }

        // bg
        int bg = getBGRow(i); // gets bg wall tile
        if(lastBG == bg){
            BGInRow++;
        }else{
            bgs += String::num_int64(lastBG) + "x";
            bgs += String::num_int64(BGInRow) + ",";
            BGInRow = 1;
            lastBG = bg;
        }

        // info
        int info = getInfoRow(i); // gets info
        if(lastInfo == info){
            InfoInRow++;
        }else{
            infostring += String::num_int64(lastInfo) + "x";
            infostring += String::num_int64(InfoInRow) + ",";
            InfoInRow = 1;
            lastInfo = info;
        }

        // time
        int time = getTimeRow(i); // gets time
        if(lastTime == time){
            TimeInRow++;
        }else{
            timestring += String::num_int64(lastTime) + "x";
            timestring += String::num_int64(TimeInRow) + ",";
            TimeInRow = 1;
            lastTime = time;
        }

        // water
        float water = getWaterRow(i); // gets water
        if(lastWater == water){
            WaterInRow++;
        }else{
            waterstring += String::num(lastWater,4) + "x";
            waterstring += String::num_int64(WaterInRow) + ",";
            WaterInRow = 1;
            lastWater = water;
        }
    
    
    }
    
    PackedStringArray collection;
    collection.append(tiles);
    collection.append(bgs);
    collection.append(infostring);
    collection.append(timestring);
    collection.append(waterstring);
    
    return collection;
}

void PLANETDATA::loadFromString(String tileString,String bgString,String infoString,String timeString,String waterString){
   
    // tile loading
    int prev = 0;
    PackedStringArray tiles = tileString.split(",");
    for(int slice = 0; slice < tiles.size(); slice++){
        String s = tiles[slice];
        int tile = s.get_slice("x",0).to_int();
        int amount = s.get_slice("x",1).to_int();  
        int wow = 0;
        for(int i = 0; i < amount; i++){
            tileData[i + prev] = tile;
            wow++;
        }
        prev += wow;
    }

    // bg loading
    prev = 0;
    PackedStringArray bg = bgString.split(",");
    for(int slice = 0; slice < bg.size(); slice++){
        String s = bg[slice];
        int tile = s.get_slice("x",0).to_int();
        int amount = s.get_slice("x",1).to_int();  
        int wow = 0;
        for(int i = 0; i < amount; i++){
            bgData[i + prev] = tile;
            wow++;
        }
        prev += wow;
    }

    // info loading
    prev = 0;
    PackedStringArray info = infoString.split(",");
    for(int slice = 0; slice < info.size(); slice++){
        String s = info[slice];
        int tile = s.get_slice("x",0).to_int();
        int amount = s.get_slice("x",1).to_int();  
        int wow = 0;
        for(int i = 0; i < amount; i++){
            infoData[i + prev] = tile;
            wow++;
        }
        prev += wow;
    }

    // time loading
    prev = 0;
    PackedStringArray time = timeString.split(",");
    for(int slice = 0; slice < time.size(); slice++){
        String s = time[slice];
        int tile = s.get_slice("x",0).to_int();
        int amount = s.get_slice("x",1).to_int();  
        int wow = 0;
        for(int i = 0; i < amount; i++){
            timeData[i + prev] = tile;
            wow++;
        }
        prev += wow;
    }

    // water loading
    prev = 0;
    PackedStringArray water = waterString.split(",");
    for(int slice = 0; slice < water.size(); slice++){
        String s = water[slice];
        float tile = s.get_slice("x",0).to_float();
        int amount = s.get_slice("x",1).to_int();  
        int wow = 0;
        for(int i = 0; i < amount; i++){
            waterData[i + prev] = tile;
            wow++;
        }
        prev += wow;
    }

}

int PLANETDATA::getTileRow(int i){
    return tileData[i];
}

int PLANETDATA::getBGRow(int i){
    return bgData[i];
}

int PLANETDATA::getInfoRow(int i){
    return infoData[i];
}

int PLANETDATA::getTimeRow(int i){
    return timeData[i];
}

float PLANETDATA::getWaterRow(int i){
    return waterData[i];
}