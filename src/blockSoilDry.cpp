#include "blockSoilDry.h"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void BLOCKSOILDRY::_bind_methods() {
}

BLOCKSOILDRY::BLOCKSOILDRY() {

    setTexture("res://items/blocks/natural/soilDry.png");

    itemToDrop = 35;
    rotateTextureToGravity = true;
    connectedTexture = true;
    connectTexturesToMe = true;
    breakParticleID = 3;
    soundMaterial = 1;

}


BLOCKSOILDRY::~BLOCKSOILDRY() {
}

Dictionary BLOCKSOILDRY::onTick(int x, int y, PLANETDATA *planet, int dir){
    
		Dictionary changes = {};


        if ( std::rand() % 100 == 0 ){
            for(int i = 0; i < 9; i++){

                Vector2i check = Vector2i( Vector2( i - 4,0 ).rotated(acos(0.0)*dir)  ) + Vector2i(x,y);

                if(abs(planet->getWaterData(check.x,check.y)) > 0.2 ){

                    changes[ Vector2i(x,y) ] = 35;// replace with wet soil if water around

                    return changes;

                }

            }

            Vector2i below = Vector2i( Vector2( 0,1 ).rotated(acos(0.0)*dir)  ) + Vector2i(x,y);
            if(abs(planet->getWaterData(below.x,below.y)) > 0.2 ){

                changes[ Vector2i(x,y) ] = 35;// replace with wet soil if water below

                return changes;

            }

            Vector2i above = Vector2i( Vector2( 0,-1 ).rotated(acos(0.0)*dir)  ) + Vector2i(x,y);
            if(abs(planet->getWaterData(above.x,above.y)) > 0.2 ){

                changes[ Vector2i(x,y) ] = 35;// replace with wet soil if water above

                return changes;

            }

            
        }
        
		return changes;

	}