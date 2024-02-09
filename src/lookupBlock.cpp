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
    data["thing"] = g->texture;
    data["rotate"] = g->rotateTextureToGravity;
    data["connectTexturesToMe"] = g->connectTexturesToMe;
    data["connectedTexture"] = g->connectedTexture;
    data["hasCollision"] = g->hasCollision;
 
 
    return data;
}

bool LOOKUPBLOCK::isConnectedTexture(int id){
    Ref<BLOCK> g = allBlocks[id];

    return g->connectedTexture;
}

bool LOOKUPBLOCK::isTextureConnector(int id){
    Ref<BLOCK> g = allBlocks[id];

    return g->connectTexturesToMe;
}