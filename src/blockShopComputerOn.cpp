#include "blockShopComputerOn.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKSHOPCOMPUTERON::_bind_methods() {
}

BLOCKSHOPCOMPUTERON::BLOCKSHOPCOMPUTERON() {

    setTexture("res://items/blocks/furniture/shop/computerON.png");

    itemToDrop = 139;
    rotateTextureToGravity = true;

    connectTexturesToMe = false;
    hasCollision = false;
    isTransparent = true;
    animated = true;


}


BLOCKSHOPCOMPUTERON::~BLOCKSHOPCOMPUTERON() {
}

Dictionary BLOCKSHOPCOMPUTERON::onTick(int x, int y, PLANETDATA *planet, int dir){
    
	Dictionary changes = {};
	
	changes[Vector2i(x,y)] = "shopCheck";
    
	return changes;

}