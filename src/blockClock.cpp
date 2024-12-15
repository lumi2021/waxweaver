#include "blockClock.h"
#include <godot_cpp/core/class_db.hpp>

#include "lookupBlock.h"

using namespace godot;

void BLOCKCLOCK::_bind_methods() {
}

BLOCKCLOCK::BLOCKCLOCK() {

    setTexture("res://items/electrical/input/clock.png");

    itemToDrop = 99;
    rotateTextureToGravity = true;


}


BLOCKCLOCK::~BLOCKCLOCK() {
}

Dictionary BLOCKCLOCK::onTick(int x, int y, PLANETDATA *planet, int dir){
    Dictionary changes = {};
	
    int info = planet->getInfoData(x,y);
    int step = 15;

    switch(info){  // what each mode means, 15 ticks per second
        case 0: step = 15; // 1 second
        break;
        case 1: step = 7; // 0.5 second
        break;
        case 2: step = 5; // 0.3 second
        break;
        case 3: step = 1; // per tick
        break;

        case 4: step = 30; // 2 second
        break;
        case 5: step = 75; // 5 second
        break;
        case 6: step = 150; // 10 second
        break;
        case 7: step = 450; // 30 second
        break;
    }

    //godot::UtilityFunctions::print( step );

    if( planet->getGlobalTick() % step == 0 ){
        //godot::UtilityFunctions::print("zap!");
        changes.merge( planet->energize(x,y,planet,lookup) ); // energize self
    }
    
	return changes;

}