#include "blockTrapdoorClosed.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKTRAPDOORCLOSED::_bind_methods() {
}

BLOCKTRAPDOORCLOSED::BLOCKTRAPDOORCLOSED() {

    setTexture("res://items/blocks/furniture/trapdoors/allTrapdoorsClosed.png");

    itemToDrop = 47;
    rotateTextureToGravity = true;
    multitile = true;
    isTransparent = true;
    connectTexturesToMe = false;
    soundMaterial = 2;
}


BLOCKTRAPDOORCLOSED::~BLOCKTRAPDOORCLOSED() {
}

Dictionary BLOCKTRAPDOORCLOSED::onTick(int x, int y, PLANETDATA *planet, int dir){

        Dictionary changes = {};
        Vector2i down = Vector2i( Vector2(0,1).rotated( acos(0.0)*dir).round()  );
        int info = planet->getInfoData(x,y) % 2; // gets info

        if (info == 0){
            if( planet->getTileData(x+down.x,y+down.y) == 25 ){ // if tile below is ladder
                planet->setInfoData(x,y,1);
                changes[Vector2i(x,y)] = 47;
            }
        }else{
            if( planet->getTileData(x+down.x,y+down.y) != 25 ){ // if tile below is NOT ladder
                planet->setInfoData(x,y,0);
                changes[Vector2i(x,y)] = 47;
            }
        }

		return changes;

	}