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
    

}

LOOKUPBLOCK::~LOOKUPBLOCK() {
}

Dictionary LOOKUPBLOCK::getBlockData(int id){
    Dictionary data ={};

    Ref<BLOCK> g = allBlocks[id];
    data["thing"] = g->texture;
 
 
    return data;
}