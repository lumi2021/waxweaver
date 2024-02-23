#include "planetData.h"
#include <godot_cpp/core/class_db.hpp>
#include <algorithm>
#include <memory>

using namespace godot;

void PLANETDATA::_bind_methods() {
   
}

void PLANETDATA::createEmptyArrays(int size) {

    int bigSize = size * size;

    tileData = new  int[bigSize];
    bgData = new  int[bigSize];
    lightData = new  int[bigSize];
    timeData = new  int[bigSize];

}


PLANETDATA::PLANETDATA() {
	tileData = NULL;
    bgData = NULL;
    lightData = NULL;
    timeData = NULL;
}

PLANETDATA::~PLANETDATA() {
	
    if (tileData != NULL) {
       
        delete [] tileData;
        
    }

    if (bgData != NULL) {
       
        delete [] bgData;
        
    }

    if (lightData != NULL) {
       
        delete [] lightData;
        
    }

    if (timeData != NULL) {
       
        delete [] timeData;
        
    }

}
