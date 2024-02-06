#include "chunkdraw.h"
#include <godot_cpp/core/class_db.hpp>


using namespace godot;

void CHUNKDRAW::_bind_methods() {
    ClassDB::bind_method(D_METHOD("generateTexturesFromData","planetData","pos","positionLookup"), &CHUNKDRAW::generateTexturesFromData);
}

CHUNKDRAW::CHUNKDRAW() {
	// Initialize any variables here.
	time_passed = 0.0;
}

CHUNKDRAW::~CHUNKDRAW() {
	// Add your cleanup here.
}

int CHUNKDRAW::generateTexturesFromData(Array planetData,Vector2i pos,Array positionLookup){
    Ref<Image> img = Image::create(64, 64, false, Image::FORMAT_RGBA8);
    Ref<Image> backImg = Image::create(64, 64, false, Image::FORMAT_RGBA8);
    
    int blockSide = 0;


    for (int x = 0; x < 8; x++){
        for (int y = 0; y < 8; y++){
            Vector2 imgPos = Vector2i(x*8,y*8);
            int worldX = x+(pos.x*8);
            int worldY = y+(pos.y*8);
            Array poop = positionLookup[worldX];
            blockSide = poop[worldY];
        }
    }


   return blockSide;

}



void CHUNKDRAW::_process(double delta) {
	time_passed += delta;

	Vector2 new_position = Vector2(10.0 + (10.0 * sin(time_passed * 2.0)), 10.0 + (10.0 * cos(time_passed * 1.5)));

	set_position(new_position);
}