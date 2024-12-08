#include "blockCalcite.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKCALCITE::_bind_methods() {
}

BLOCKCALCITE::BLOCKCALCITE() {

    setTexture("res://items/blocks/natural/calcite.png");

    itemToDrop = 80;
    rotateTextureToGravity = true;
    natural = true;
}


BLOCKCALCITE::~BLOCKCALCITE() {
}

Dictionary BLOCKCALCITE::onTick(int x, int y, PLANETDATA *planet, int dir){

    Dictionary changes = {};
    
    int timeAlive = planet->getGlobalTick() - planet->getTimeData(x,y);

    if (timeAlive > 1000){

        int woah = (timeAlive / 1000);                              // this snippet of code makes it so that if 1000 ticks old, theres only a 10% chance of crystal growing
        if (woah < 10){                                             // however, for every 1000 ticks old, the chance of growth is more likely
            if (std::rand() % (10-woah) != 0){                      // this is so there will be plenty of crystals if u leave and come back, as if u had waited there
                planet->setTimeData(x,y,planet->getGlobalTick());
                return changes;
            }
        }

        Vector2i below = Vector2i(Vector2(0,1).rotated(acos(0.0)*dir));
        if( planet->getTileData(below.x + x,below.y + y) > 1 ){ // reset clock if block in the way
            planet->setTimeData(x,y,planet->getGlobalTick());
            return changes;
        }

        if( planet->getPositionLookup(below.x + x,below.y + y) != dir ){ // reset clock if growing into turned corner
            planet->setTimeData(x,y,planet->getGlobalTick());
            return changes;
        }


        if( dir % 2 == 0 ){ // this function makes sure crystals won't grow next to each other
            if(x % 2 == 0){
                return changes;
            }

        }else{
            if(y % 2 == 0){
                return changes;
            }
        }
        changes[ Vector2i(below.x + x,below.y + y) ] = 81;
        planet->setInfoData( below.x + x,below.y + y,  std::rand() % 3 );

    }



	return changes;

}