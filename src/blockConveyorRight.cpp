#include "blockConveyorRight.h"
#include <godot_cpp/core/class_db.hpp>

#include "lookupBlock.h"

using namespace godot;

void BLOCKCONVEYORRIGHT::_bind_methods() {
}

BLOCKCONVEYORRIGHT::BLOCKCONVEYORRIGHT() {

    setTexture("res://items/electrical/conveyorbelt/rightBelt.png");

    itemToDrop = 105;
    rotateTextureToGravity = true;
    connectedTexture = true;
    connectTexturesToMe = false;
    connectToSelfOnly = true;
    isTransparent = true;
    animated = true;
}


BLOCKCONVEYORRIGHT::~BLOCKCONVEYORRIGHT() {
}