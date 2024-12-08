#include "blockGrass.h"
#include <godot_cpp/core/class_db.hpp>
#include "lookupBlock.h"

using namespace godot;

void BLOCKGRASS::_bind_methods() {
}

BLOCKGRASS::BLOCKGRASS() {

    setTexture("res://items/blocks/natural/grass.png");

    connectedTexture = true;

    itemToDrop = 3;
    breakParticleID = 3;
    soundMaterial = 1;

}


BLOCKGRASS::~BLOCKGRASS() {
}

Dictionary BLOCKGRASS::onTick(int x, int y, PLANETDATA *planet, int dir) {


    Dictionary changes = {};

    // grow foliage 17, 38
    int timeAlive = planet->getGlobalTick() - planet->getTimeData(x,y);
    if (timeAlive > 9000){
        if(std::rand() % 10 != 0 ){
            planet->setTimeData(x,y,planet->getGlobalTick());
            return changes;
        }
        
        Vector2i above = Vector2i(Vector2(0,-1).rotated(acos(0.0)*dir));
        
        if( planet->getTileData(x+above.x,y+above.y) > 1 ){
            return changes;
        }

        int newid = 17;

        if (std::rand() % 20 == 0 ){
            newid = 38;
        }

        changes[Vector2i(x+above.x,y+above.y)] = newid;
        planet->setTimeData(x,y,planet->getGlobalTick());
        return changes;

    }


    if (std::rand() % 500 != 0) {
        return changes;
    }

    // Remove self if covered
    int points = 0;
    for (int i = 0; i < 4; i++){
                    
        Vector2 pee = Vector2(0,1).rotated(acos(0.0) * i);
        
        if(lookup->hasCollision(planet->getTileData(x+pee.x,y+pee.y))){
            
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
                   
                    if(!lookup->hasCollision(planet->getTileData(x+v.x+pee.x,y+v.y+pee.y))){
                   
                        changes[Vector2i(Vector2(x+v.x,y+v.y))] = 4;
                        break;

                    }

                }

            }
    
        }
    }



    
    return changes;
    
}

Dictionary BLOCKGRASS::onBreak(int x, int y, PLANETDATA *planet, int dir){
    
    Dictionary changes = {};

    Vector2i newPos =  Vector2i(x,y) - Vector2i( Vector2(0,1).rotated(acos(0.0)*dir) );
    int tile = planet->getTileData(newPos.x,newPos.y);
    if(tile == 8){
        changes[newPos] = -1;
    }
    return changes;
}