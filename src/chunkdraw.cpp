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

Array CHUNKDRAW::generateTexturesFromData(Array planetData,Vector2i pos,Array positionLookup,Node *body,Ref<Shape2D> shape){
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
            int backBlockID = fullLayerData[1];

            if (blockID>1){
                //ideally move blockimage conversion to block specific code
                Dictionary blockData = cock->getBlockData(blockID);
                Ref<Texture2D> blockRes = blockData["thing"];
                Ref<Image> blockImg = blockRes->get_image();
                blockImg->convert(Image::FORMAT_RGBA8);

                
                bool rotate = blockData["rotate"];
                if (rotate){ 
                    for(int g = 0; g < blockSide; g++){
                        blockImg->rotate_90(ClockDirection::CLOCKWISE);
                    }
                }

                int frame = 0;
                if(blockData["connectedTexture"]){ frame = scanBlockOpen(planetData,worldX,worldY,0); }
                Rect2i blockRect = Rect2i(frame,0,8,8);

                

                img->blend_rect(blockImg, blockRect, imgPos);

                //This is where collision stuff will go
                if(blockData["hasCollision"]){

                    CollisionShape2D *collision;
                    collision = memnew(CollisionShape2D);
                    collision->set_shape(shape);
                    Vector2 offset = Vector2(4,4);
                    collision->set_position(imgPos + offset);
                    body->add_child(collision);

                    continue;
                }

            }


            if (backBlockID>1){
                //ideally move blockimage conversion to block specific code
                Dictionary blockData = cock->getBlockData(backBlockID);
                Ref<Texture2D> blockRes = blockData["thing"];
                Ref<Image> blockImg = blockRes->get_image();
                blockImg->convert(Image::FORMAT_RGBA8);

                
                bool rotate = blockData["rotate"];
                if (rotate){ 
                    for(int g = 0; g < blockSide; g++){
                        blockImg->rotate_90(ClockDirection::CLOCKWISE);
                    }
                }

                int frame = 0;
                if(blockData["connectedTexture"]){ frame = scanBlockOpen(planetData,worldX,worldY,1); }
                Rect2i blockRect = Rect2i(frame,0,8,8);

                

                backImg->blend_rect(blockImg, blockRect, imgPos);

            }

        }
    }


    //emit_signal("chunkDrawn", this, img, backImg);


    images.append(img);
    images.append(backImg);

   return images;

}

int CHUNKDRAW::scanBlockOpen(Array planetData,int x,int y,int layer){
	int openL = 1;
	int openR = 2;
	int openT = 4;
	int openB = 8;
	//what the fuck is this

    int hasTileL = tileInRange(x-1, y, planetData);
    Array layerData = getTileFromData(x-1, y, planetData);
    int connectTexturesToMe = !cock->isTextureConnector(layerData[layer]);
    openL = 1 * hasTileL * connectTexturesToMe;

    int hasTileR = tileInRange(x+1, y, planetData);
    layerData = getTileFromData(x+1, y, planetData);
    connectTexturesToMe = !cock->isTextureConnector(layerData[layer]);
    openR = 2 * hasTileR * connectTexturesToMe;

    int hasTileT = tileInRange(x, y-1, planetData);
    layerData = getTileFromData(x, y-1, planetData);
    connectTexturesToMe = !cock->isTextureConnector(layerData[layer]);
    openT = 4 * hasTileT * connectTexturesToMe;

    int hasTileB = tileInRange(x, y+1, planetData);
    layerData = getTileFromData(x, y+1, planetData);
    connectTexturesToMe = !cock->isTextureConnector(layerData[layer]);
    openB = 8 * hasTileB * connectTexturesToMe;

	return (openL + openR + openT + openB) * 8;
}

Array CHUNKDRAW::getTileFromData(int x, int y, Array planetData){  
    int size = planetData.size();

    Array empty;

    if(x < 0){return empty;}
    if(x > size-1){return empty;}
    if(y < 0){return empty;}
    if(y > size-1){return empty;}
    
    Array dataX = planetData[x];
    Array fullLayerData = dataX[y];

    return fullLayerData;
}

int CHUNKDRAW::tileInRange(int x, int y, Array planetData){
    int size = planetData.size();

    if(x < 0){return 0;}
    if(x > size-1){return 0;}
    if(y < 0){return 0;}
    if(y > size-1){return 0;}

    return 1;
}



void CHUNKDRAW::_process(double delta) {
	time_passed += delta;

	Vector2 new_position = Vector2(10.0 + (10.0 * sin(time_passed * 2.0)), 10.0 + (10.0 * cos(time_passed * 1.5)));

	set_position(new_position);
}