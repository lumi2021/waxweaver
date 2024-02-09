#include "chunkdraw.h"
#include <godot_cpp/core/class_db.hpp>


using namespace godot;

void CHUNKDRAW::_bind_methods() {
    ClassDB::bind_method(D_METHOD("generateTexturesFromData","planetData","pos","positionLookup"), &CHUNKDRAW::generateTexturesFromData);
    ADD_SIGNAL(MethodInfo("chunkDrawn", PropertyInfo(Variant::OBJECT, "node"), PropertyInfo(Variant::OBJECT, "image"), PropertyInfo(Variant::OBJECT, "backImage")));
}

CHUNKDRAW::CHUNKDRAW() {
	time_passed = 0.0;
    cock = memnew(LOOKUPBLOCK);
}

CHUNKDRAW::~CHUNKDRAW() {
	// Add your cleanup here.
}

Array CHUNKDRAW::generateTexturesFromData(Array planetData,Vector2i pos,Array positionLookup){
    Ref<Image> img = Image::create(64, 64, false, Image::FORMAT_RGBA8);
    Ref<Image> backImg = Image::create(64, 64, false, Image::FORMAT_RGBA8);
    
    Array images;

    for (int x = 0; x < 8; x++){
        for (int y = 0; y < 8; y++){
            
            Vector2 imgPos = Vector2i(x*8,y*8);
            int worldX = x+(pos.x*8);
            int worldY = y+(pos.y*8);
            
            Array lookY = positionLookup[worldX];
            int blockSide = lookY[worldY];

            Array dataX = planetData[worldX];
            Array fullLayerData = dataX[worldY];
           
            int blockID = fullLayerData[0];

            if (blockID>1){
                //ideally move blockimage conversion to block specific code
                Dictionary blockData = cock->getBlockData(blockID);
                Ref<Texture2D> blockRes = blockData["thing"];
                Ref<Image> blockImg = blockRes->get_image();
                blockImg->convert(Image::FORMAT_RGBA8);

                
                bool rotate = blockData["rotate"];
                for(int g = 0; g < blockSide; g++){
                    blockImg->rotate_90(ClockDirection::CLOCKWISE);
                }

                //fix this
                //int frame = scanBlockOpen(planetData,worldPos.x,worldPos.y,0) * int(BlockData.data[blockId].connectedTexture)
                Rect2i blockRect = Rect2i(0,0,8,8);

                

                img->blend_rect(blockImg, blockRect, imgPos);
            }

        }
    }


    emit_signal("chunkDrawn", this, img, backImg);


   return images;

}

int scanBlockOpen(Array planetData,int x,int y,int layer){
	int openL = 1;
	int openR = 2;
	int openT = 4;
	int openB = 8;
	//what the fuck is this
	//openL = 1 * int(!BlockData.data[planetData[x-(1*int(x != 0))][y][layer]].texturesConnectToMe)
	//openR = 2 * int(!BlockData.data[planetData[x+(1*int(x != planetData.size()-1))][y][layer]].texturesConnectToMe)
	//openT = 4 * int(!BlockData.data[planetData[x][y-(1 * int(y != 0))][layer]].texturesConnectToMe)
	//openB = 8 * int(!BlockData.data[planetData[x][y+(1 * int(y != planetData.size()-1))][layer]].texturesConnectToMe)
	
	return (openL + openR + openT + openB) * 8;
}

void CHUNKDRAW::_process(double delta) {
	time_passed += delta;

	Vector2 new_position = Vector2(10.0 + (10.0 * sin(time_passed * 2.0)), 10.0 + (10.0 * cos(time_passed * 1.5)));

	set_position(new_position);
}