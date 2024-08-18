#include "blockTorch.h"
#include <godot_cpp/core/class_db.hpp>

#include <godot_cpp/variant/utility_functions.hpp>

#include "lookupBlock.h"

using namespace godot;

void BLOCKTORCH::_bind_methods() {
}

BLOCKTORCH::BLOCKTORCH() {

    setTexture("res://items/torches/torch.png");

    breakTime = 0.0;

    breakParticleID = 13;

    hasCollision = false;

    lightMultiplier = 1.0;
    lightEmmission = 2.8;

    rotateTextureToGravity = true;

    connectTexturesToMe = false;

    itemToDrop = 15;

    animated = true;
    multitile = true;

    isTransparent = true;

}


BLOCKTORCH::~BLOCKTORCH() {
}

Dictionary BLOCKTORCH::onTick(int x, int y, PLANETDATA *planet, int dir){
    
	Dictionary changes = {};

    int selfId = 15;
    
	if (planet->getWaterData(x,y) > 0.2 ){

        changes[ Vector2i(x,y) ] = -1;
        return changes;

    }

    int type = planet->getInfoData(x,y);

    if( type == 0 ){

        if( planet->getBGData(x,y) < 2 ){
            changes[ Vector2i(x,y) ] = -1;
        }

        return changes;
    }

    if( type == 1 ){

        Vector2i D = Vector2i( Vector2(0,1).rotated(acos(0.0)*dir) ) + Vector2i(x,y);

        if( planet->getTileData(D.x,D.y) < 2 ){
            planet->setInfoData(x,y,0);
            changes[ Vector2i(x,y) ] = selfId;
        }

        return changes;
    }

    if( type == 2 ){

        Vector2i D = Vector2i( Vector2(1,0).rotated(acos(0.0)*dir) ) + Vector2i(x,y);

        if( planet->getTileData(D.x,D.y) < 2 ){
            planet->setInfoData(x,y,0);
            changes[ Vector2i(x,y) ] = selfId;
        }

        return changes;
    }

    if( type == 3 ){

        Vector2i D = Vector2i( Vector2(-1,0).rotated(acos(0.0)*dir) ) + Vector2i(x,y);

        if( planet->getTileData(D.x,D.y) < 2 ){
            planet->setInfoData(x,y,0);
            changes[ Vector2i(x,y) ] = selfId;
        }

        return changes;
    }


    
    
    return changes;

}