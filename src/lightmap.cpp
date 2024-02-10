#include "lightmap.h"
#include <godot_cpp/core/class_db.hpp>
#include <algorithm>

using namespace godot;

void LIGHTMAP::_bind_methods() {
    ClassDB::bind_method(D_METHOD("generateLightTexture","x","y","lightData"), &LIGHTMAP::generateLightTexture);
    ADD_SIGNAL(MethodInfo("image_updated", PropertyInfo(Variant::OBJECT, "node"), PropertyInfo(Variant::OBJECT, "image")));
}

LIGHTMAP::LIGHTMAP() {
	img = Image::create(64, 64, false, Image::FORMAT_RGBA8);
}

LIGHTMAP::~LIGHTMAP() {
	// Initialize any variables here.
}



void LIGHTMAP::generateLightTexture(int x, int y,Array lightData){
    
    int size = lightData.size()-1;

    for (int imgX = 0; imgX < 64; imgX++){
        for (int imgY = 0; imgY < 64; imgY++){



            int newX = std::clamp(x+imgX,0,size);
            int newY = std::clamp(y+imgY,0,size);
            
            Array p = lightData[newX];
            float l = p[newY];

            Color c = Color::hex(0x000000FF);
            c.r = l;
            c.g = l;
            c.b = l;

            img->set_pixel(imgX,imgY,c);


        }
    }

   emit_signal("image_updated", this, img);

}

void LIGHTMAP::_process(double delta) {

	//generateLightTexture(0, 0, Array lightData);

}