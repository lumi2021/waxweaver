#include "lookupBlock.h"

#include "block.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void LOOKUPBLOCK::_bind_methods() {
    ClassDB::bind_method(D_METHOD("getBlockData","id"), &LOOKUPBLOCK::getBlockData);
}

LOOKUPBLOCK::LOOKUPBLOCK() {
    
    Ref<BLOCKAIR> air;
    air.instantiate();
    allBlocks.append(air);
    
    Ref<BLOCKCAVEAIR> caveair;
    caveair.instantiate();
    allBlocks.append(caveair);
    
    Ref<BLOCKSTONE> stone;
    stone.instantiate();
    allBlocks.append(stone);

    Ref<BLOCKDIRT> dirt;
    dirt.instantiate();
    allBlocks.append(dirt);

    Ref<BLOCKGRASS> grass;
    grass.instantiate();
    allBlocks.append(grass);

    Ref<BLOCKCORE> core;
    core.instantiate();
    allBlocks.append(core);



}

LOOKUPBLOCK::~LOOKUPBLOCK() {
}

Dictionary LOOKUPBLOCK::getBlockData(int id){
    Dictionary data ={};

    Ref<BLOCK> g = allBlocks[id];
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
    Ref<BLOCK> g = allBlocks[id];

    return g->hasCollision;
}

bool LOOKUPBLOCK::isGravityRotate(int id){
    Ref<BLOCK> g = allBlocks[id];

    return g->rotateTextureToGravity;
}

bool LOOKUPBLOCK::isConnectedTexture(int id){
    Ref<BLOCK> g = allBlocks[id];

    return g->connectedTexture;
}

Ref<Image> LOOKUPBLOCK::getTextureImage(int id){
    Ref<BLOCK> g = allBlocks[id];

    return g->texImage;
}


bool LOOKUPBLOCK::isTextureConnector(int id){
    Ref<BLOCK> g = allBlocks[id];

    return g->connectTexturesToMe;
}

double LOOKUPBLOCK::getLightMultiplier(int id){
    Ref<BLOCK> g = allBlocks[id];

    return g->lightMultiplier;
}

double LOOKUPBLOCK::getLightEmmission(int id){
    Ref<BLOCK> g = allBlocks[id];

    return g->lightEmmission;
}

Dictionary LOOKUPBLOCK::runOnTick(int x, int y, PLANETDATA *planet, int dir, int blockID){

    Ref<BLOCK> g = allBlocks[blockID];

    return g->onTick(x,y,planet,dir);
}