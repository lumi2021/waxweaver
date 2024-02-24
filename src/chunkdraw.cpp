#include "chunkdraw.h"
#include <godot_cpp/core/class_db.hpp>


using namespace godot;

void CHUNKDRAW::_bind_methods() {
    ClassDB::bind_method(D_METHOD("generateTexturesFromData","planetData","backgroundLayerData","pos","positionLookup"), &CHUNKDRAW::generateTexturesFromData);
    ClassDB::bind_method(D_METHOD("tickUpdate","planetDatac","pos"), &CHUNKDRAW::tickUpdate);
    ClassDB::bind_method(D_METHOD("getBlockDictionary","id"), &CHUNKDRAW::getBlockDictionary);
    ClassDB::bind_method(D_METHOD("scanBlockOpen","planetDATAC","x","y"), &CHUNKDRAW::scanBlockOpen);
    ADD_SIGNAL(MethodInfo("chunkDrawn", PropertyInfo(Variant::OBJECT, "node"), PropertyInfo(Variant::OBJECT, "image"), PropertyInfo(Variant::OBJECT, "backImage")));
}

CHUNKDRAW::CHUNKDRAW() {
	time_passed = 0.0;
    cock = memnew(LOOKUPBLOCK);
}

CHUNKDRAW::~CHUNKDRAW() {
	// Add your cleanup here.
}

Dictionary CHUNKDRAW::getBlockDictionary(int id){
    Dictionary blockData = cock->getBlockData(id);
    return blockData;
}

Array CHUNKDRAW::generateTexturesFromData(PLANETDATA *planet,Vector2i pos,Node *body,Ref<Shape2D> shape){
    Ref<Image> img = Image::create(64, 64, false, Image::FORMAT_RGBA8);
    Ref<Image> backImg = Image::create(64, 64, false, Image::FORMAT_RGBA8);
    
    Array images;
    
    for (int x = 0; x < 8; x++){
        for (int y = 0; y < 8; y++){
            
            Vector2 imgPos = Vector2i(x*8,y*8);
            int worldX = x+(pos.x*8);
            int worldY = y+(pos.y*8);

            int planetSize = planet->planetSize; // GETS PASSED IN

            int blockSide = planet->getPositionLookup(worldX,worldY);

            int blockID = planet->getTileData(worldX,worldY);
            int backBlockID = planet->getBGData(worldX,worldY);

            if (blockID>1){
                //ideally move blockimage conversion to block specific code
                Dictionary blockData = cock->getBlockData(blockID);
                Ref<Texture2D> blockRes = blockData["texture"];
                Ref<Image> blockImg = blockRes->get_image();
                blockImg->convert(Image::FORMAT_RGBA8);

                
                bool rotate = cock->isGravityRotate(blockID);
                if (rotate){ 
                    for(int g = 0; g < blockSide; g++){
                        blockImg->rotate_90(ClockDirection::CLOCKWISE);
                    }
                }

                int frame = 0;
                if( cock->isConnectedTexture(blockID) ){ frame = scanBlockOpen(planet,worldX,worldY); }
                Rect2i blockRect = Rect2i(frame,0,8,8);

                

                img->blend_rect(blockImg, blockRect, imgPos);

                // THIS IS WHERE WE CREATE THE COLLISION //
                if( cock->hasCollision(blockID) ) {

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
                Ref<Texture2D> blockRes = blockData["texture"];
                Ref<Image> blockImg = blockRes->get_image();
                blockImg->convert(Image::FORMAT_RGBA8);

                
                bool rotate = cock->isGravityRotate(backBlockID);
                if (rotate){ 
                    for(int g = 0; g < blockSide; g++){
                        blockImg->rotate_90(ClockDirection::CLOCKWISE);
                    }
                }

                int frame = 0;
                if( cock->isConnectedTexture(backBlockID) ) { frame = scanBlockOpen(planet,worldX,worldY); }
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

void CHUNKDRAW::tickUpdate(PLANETDATA *planet,Vector2i pos){

    for(int x = 0; x < 8; x++){
        for(int y = 0; y < 8; y++){
            int worldX = x+(pos.x*8);
            int worldY = y+(pos.y*8);

            int planetSize = planet->planetSize; // GETS PASSED IN
            
            int blockID = planet->getTileData(worldX,worldY);

            //int blockSide = positionLookup[arrayPosition];

            // SIMULATE LIGHT //
           
            double currentLight = planet->getLightData(worldX,worldY);
            int hasPosL = worldX > 0;
            int hasPosR = worldX < planetSize-1;
            int hasPosT = worldY > 0;
            int hasPosB = worldY < planetSize-1;


            double lightL = planet->getLightData(worldX - 1,worldY);

            double lightR = planet->getLightData(worldX + 1,worldY);
            
            double lightB = planet->getLightData(worldX,worldY + 1);

            double lightT = planet->getLightData(worldX,worldY - 1);

            //average light values
            double mutliplier = cock->getLightMultiplier(blockID);
            double newLight = ( ( lightB + lightL + lightR + lightT ) / 4.0 ) * mutliplier;
            double lightEmmission = cock->getLightEmmission(blockID);
            newLight = std::max(newLight,lightEmmission);
            newLight = std::clamp(newLight,0.0,1.0);

            planet->setLightData(worldX,worldY,newLight);

        }

   }
        
}



int CHUNKDRAW::scanBlockOpen(PLANETDATA *planet,int x,int y){
	int openL = 1;
	int openR = 2;
	int openT = 4;
	int openB = 8;
	//what the fuck is this

    int blockID = planet->getTileData(x-1,y);
    int connectTexturesToMe = !cock->isTextureConnector(blockID);
    openL = 1 * connectTexturesToMe;

    blockID = planet->getTileData(x+1,y);
    connectTexturesToMe = !cock->isTextureConnector(blockID);
    openR = 2 * connectTexturesToMe;


    blockID = planet->getTileData(x,y-1);
    connectTexturesToMe = !cock->isTextureConnector(blockID);
    openT = 4 * connectTexturesToMe;

    blockID = planet->getTileData(x,y+1);
    connectTexturesToMe = !cock->isTextureConnector(blockID);
    openB = 8 * connectTexturesToMe;

	return (openL + openR + openT + openB) * 8;
}