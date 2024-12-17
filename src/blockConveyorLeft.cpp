#include "blockConveyorLeft.h"
#include <godot_cpp/core/class_db.hpp>

#include "lookupBlock.h"

using namespace godot;

void BLOCKCONVEYORLEFT::_bind_methods() {
}

BLOCKCONVEYORLEFT::BLOCKCONVEYORLEFT() {

    setTexture("res://items/electrical/conveyorbelt/leftBelt.png");

    itemToDrop = 105;
    rotateTextureToGravity = true;
    connectedTexture = true;
    connectTexturesToMe = false;
    connectToSelfOnly = true;
    isTransparent = true;
    animated = true;
}


BLOCKCONVEYORLEFT::~BLOCKCONVEYORLEFT() {
}