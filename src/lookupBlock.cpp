#include "lookupBlock.h"

#include "block.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void LOOKUPBLOCK::_bind_methods() {
    ClassDB::bind_method(D_METHOD("getBlockData","id"), &LOOKUPBLOCK::getBlockData);
}

// ADD BLOCKS TO ARRAY IN HERE
LOOKUPBLOCK::LOOKUPBLOCK() {
    
    penis[0] = new BLOCKAIR();
    penis[1] = new BLOCKCAVEAIR();
    penis[2] = new BLOCKSTONE();
    penis[3] = new BLOCKDIRT();
    penis[4] = new BLOCKGRASS();
    penis[5] = new BLOCKCORE();
    
    
    //Ref<BLOCKAIR> air;
    //air.instantiate();
    //allBlocks.append(air);
    
    //Ref<BLOCKCAVEAIR> caveair;
    //caveair.instantiate();
    //allBlocks.append(caveair);
    
    //Ref<BLOCKSTONE> stone;
    //stone.instantiate();
    //allBlocks.append(stone);

    //Ref<BLOCKDIRT> dirt;
    //dirt.instantiate();
    //allBlocks.append(dirt);

    //Ref<BLOCKGRASS> grass;
    //grass.instantiate();
    //allBlocks.append(grass);

    //Ref<BLOCKCORE> core;
    //core.instantiate();
    //allBlocks.append(core);

}

LOOKUPBLOCK::~LOOKUPBLOCK() {
}

Dictionary LOOKUPBLOCK::getBlockData(int id){
    Dictionary data ={};

    BLOCK* g = penis[id];
    data["texture"] = g->texture;
    data["rotateTextureToGravity"] = g->rotateTextureToGravity;
    data["connectTexturesToMe"] = g->connectTexturesToMe;
    data["connectedTexture"] = g->connectedTexture;
    data["hasCollision"] = g->hasCollision;
    data["itemToDrop"] = g->itemToDrop;
    data["breakParticleID"] = g->breakParticleID;
    data["breakTime"]= g->breakTime;
    data["lightMultiplier"] = g->lightMultiplier;
    data["lightEmmission"] = g->lightEmmission;

    return data;
}

bool LOOKUPBLOCK::hasCollision(int id){
    BLOCK* g = penis[id];

    return g->hasCollision;
}

bool LOOKUPBLOCK::isGravityRotate(int id){
    BLOCK* g = penis[id];

    return g->rotateTextureToGravity;
}

bool LOOKUPBLOCK::isConnectedTexture(int id){
    BLOCK* g = penis[id];

    return g->connectedTexture;
}

Ref<Image> LOOKUPBLOCK::getTextureImage(int id){
    BLOCK* g = penis[id];

    return g->texImage;
}


bool LOOKUPBLOCK::isTextureConnector(int id){
    BLOCK* g = penis[id];

    return g->connectTexturesToMe;
}

double LOOKUPBLOCK::getLightMultiplier(int id){
    BLOCK* g = penis[id];

    return g->lightMultiplier;
}

double LOOKUPBLOCK::getLightEmmission(int id){
    BLOCK* g = penis[id];

    return g->lightEmmission;
}

Dictionary LOOKUPBLOCK::runOnTick(int x, int y, PLANETDATA *planet, int dir, int blockID){

   // BLOCK* g = penis[blockID];
   
    return penis[blockID]->onTick(x,y,planet,dir);
}

////////////////////////////////////////////////////////////////////
///////////////////////// SIMULATION ///////////////////////////////
////////////////////////////////////////////////////////////////////

// This is where we will put the onTick simulation code.
// Multiple Tiles should be able to run the same functions