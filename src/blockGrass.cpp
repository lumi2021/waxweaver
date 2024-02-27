#include "blockGrass.h"
#include <godot_cpp/core/class_db.hpp>


using namespace godot;

void BLOCKGRASS::_bind_methods() {
}

BLOCKGRASS::BLOCKGRASS() {

    setTexture("res://block_resources/block_textures/grass.png");

    connectedTexture = true;

    itemToDrop = 0;
    breakParticleID = 3;

}


BLOCKGRASS::~BLOCKGRASS() {
}

Dictionary BLOCKGRASS::onTick(int x, int y, PLANETDATA *planet, int dir) {


    Dictionary changes = {};

    if (std::rand() % 500 != 0) {
        return changes;
    }

    // Remove self if covered
    int points = 0;
    for (int i = 0; i < 4; i++){
                    
        Vector2 pee = Vector2(0,1).rotated(acos(0.0) * i);
                   
        if(planet->getTileData(x+pee.x,y+pee.y)>1){
            
            points += 1;

        }
    }
    if (points == 4){
        changes[Vector2i(Vector2(x,y))] = 3;
        return changes;
    }


    for (int xx = 0; xx < 3; xx++){
        for (int yy = 0; yy < 3; yy++){
            Vector2 v = Vector2(xx-1,yy-1);
            
            if(planet->getTileData(x+v.x,y+v.y)==3){
               // changes[Vector2i(Vector2(x+v.x,y+v.y))] = 4;

                for (int i = 0; i < 4; i++){
                    
                    Vector2 pee = Vector2(0,1).rotated(acos(0.0) * i);
                   
                    if(planet->getTileData(x+v.x+pee.x,y+v.y+pee.y)<2){
                   
                        changes[Vector2i(Vector2(x+v.x,y+v.y))] = 4;
                        break;

                    }

                }

            }
    
        }
    }
    
    return changes;
    
}