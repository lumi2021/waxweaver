#include "chunkdraw.h"
#include <godot_cpp/core/class_db.hpp>


using namespace godot;

void CHUNKDRAW::_bind_methods() {
    ClassDB::bind_method(D_METHOD("generateTexturesFromData","planetData","backgroundLayerData","pos","positionLookup"), &CHUNKDRAW::generateTexturesFromData);
    ClassDB::bind_method(D_METHOD("tickUpdate","planetData","pos","positionLookup","lightdata"), &CHUNKDRAW::tickUpdate);
    ADD_SIGNAL(MethodInfo("chunkDrawn", PropertyInfo(Variant::OBJECT, "node"), PropertyInfo(Variant::OBJECT, "image"), PropertyInfo(Variant::OBJECT, "backImage")));
}

CHUNKDRAW::CHUNKDRAW() {
	time_passed = 0.0;
    cock = memnew(LOOKUPBLOCK);
}

CHUNKDRAW::~CHUNKDRAW() {
	// Add your cleanup here.
}

Array CHUNKDRAW::generateTexturesFromData(Array planetData,Array backgroundLayerData,Vector2i pos,Array positionLookup,Node *body,Ref<Shape2D> shape){
    Ref<Image> img = Image::create(64, 64, false, Image::FORMAT_RGBA8);
    Ref<Image> backImg = Image::create(64, 64, false, Image::FORMAT_RGBA8);
    
    Array images;
    
    for (int x = 0; x < 8; x++){
        for (int y = 0; y < 8; y++){
            
            Vector2 imgPos = Vector2i(x*8,y*8);
            int worldX = x+(pos.x*8);
            int worldY = y+(pos.y*8);

            int planetSize = 128; // THIS WILL BE PASSED IN INSTEAD LATER
            int arrayPosition = (worldX * planetSize) + worldY;

            int blockSide = positionLookup[arrayPosition];

            int blockID = planetData[arrayPosition];
            int backBlockID = backgroundLayerData[arrayPosition];

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
                if(blockData["connectedTexture"]){ frame = scanBlockOpen(planetData,worldX,worldY); }
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
                if(blockData["connectedTexture"]){ frame = scanBlockOpen(backgroundLayerData,worldX,worldY); }
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

void CHUNKDRAW::tickUpdate(Array planetData,Vector2i pos,Array positionLookup,Array lightData){

    for(int x = 0; x < 8; x++){
        for(int y = 0; y < 8; y++){
            int worldX = x+(pos.x*8);
            int worldY = y+(pos.y*8);

            int planetSize = 128; // THIS WILL BE PASSED IN INSTEAD LATER
            int arrayPosition = (worldX * planetSize) + worldY;
            
            int blockID = planetData[arrayPosition];

            int blockSide = positionLookup[arrayPosition];

            // SIMULATE LIGHT //
           
            double currentLight = lightData[arrayPosition];
            int hasPosL = worldX > 0;
            int hasPosR = worldX < planetSize-1;
            int hasPosT = worldY > 0;
            int hasPosB = worldY < planetSize-1;


            int arrayPosL = ((worldX-(1*hasPosL)) * planetSize) + worldY;
            double lightL = lightData[arrayPosL];

            int arrayPosR = ((worldX+(1*hasPosR)) * planetSize) + worldY;
            double lightR = lightData[arrayPosR];
            
            int arrayPosB = (worldX * planetSize) + worldY + (1*hasPosB);
            double lightB = lightData[arrayPosB];

            int arrayPosT = (worldX * planetSize) + worldY - (1*hasPosT);
            double lightT = lightData[arrayPosT];

            //average light values
            double mutliplier = cock->getLightMultiplier(blockID);
            double newLight = ( ( lightB + lightL + lightR + lightT ) / 4.0 ) * mutliplier;
            double lightEmmission = cock->getLightEmmission(blockID);
            newLight = std::max(newLight,lightEmmission);
            newLight = std::clamp(newLight,0.0,1.0);

            lightData[arrayPosition] = newLight;

        }

   }
        
}



int CHUNKDRAW::scanBlockOpen(Array data,int x,int y){
	int openL = 1;
	int openR = 2;
	int openT = 4;
	int openB = 8;
	//what the fuck is this

    int blockID = getTileFromData(x-1, y, data);
    int connectTexturesToMe = !cock->isTextureConnector(blockID);
    openL = 1 * connectTexturesToMe;

    blockID = getTileFromData(x+1, y, data);
    connectTexturesToMe = !cock->isTextureConnector(blockID);
    openR = 2 * connectTexturesToMe;


    blockID = getTileFromData(x, y-1, data);
    connectTexturesToMe = !cock->isTextureConnector(blockID);
    openT = 4 * connectTexturesToMe;

    blockID = getTileFromData(x, y+1, data);
    connectTexturesToMe = !cock->isTextureConnector(blockID);
    openB = 8 * connectTexturesToMe;

	return (openL + openR + openT + openB) * 8;
}

int CHUNKDRAW::getTileFromData(int x, int y, Array data){  
    int size = 128; // CHANGE THIS TO NOT BE HARDCODED LATER !!!!
    int arrayPosition = (x * size) + y;
    
    Array empty;

    if(x < 0){return 0;}
    if(x > size-1){return 0;}
    if(y < 0){return 0;}
    if(y > size-1){return 0;}
    
    int blockID = data[arrayPosition];

    return blockID;
}

int CHUNKDRAW::tileInRange(int x, int y, Array planetData){
    int size = 128; // CHANGE THIS TO NOT BE HARDCODED LATER !!!!

    if(x < 0){return 0;}
    if(x > size-1){return 0;}
    if(y < 0){return 0;}
    if(y > size-1){return 0;}

    return 1;
}



void CHUNKDRAW::_process(double delta) {
	
}