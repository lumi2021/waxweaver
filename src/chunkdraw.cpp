#include "chunkdraw.h"
#include <godot_cpp/core/class_db.hpp>


using namespace godot;

void CHUNKDRAW::_bind_methods() {
    ClassDB::bind_method(D_METHOD("generateTexturesFromData","planetData","backgroundLayerData","pos","positionLookup"), &CHUNKDRAW::generateTexturesFromData);
    ClassDB::bind_method(D_METHOD("tickUpdate","planetDatac","pos"), &CHUNKDRAW::tickUpdate);
    ClassDB::bind_method(D_METHOD("runBreak","planetDatac","pos","x","y","id"), &CHUNKDRAW::runBreak);
    ClassDB::bind_method(D_METHOD("getBlockDictionary","id"), &CHUNKDRAW::getBlockDictionary);
    ClassDB::bind_method(D_METHOD("scanBlockOpen","planetDATAC","x","y"), &CHUNKDRAW::scanBlockOpen);
    ADD_SIGNAL(MethodInfo("chunkDrawn", PropertyInfo(Variant::OBJECT, "node"), PropertyInfo(Variant::OBJECT, "image"), PropertyInfo(Variant::OBJECT, "backImage")));
}

CHUNKDRAW::CHUNKDRAW() {
	time_passed = 0.0;
    cock = memnew(LOOKUPBLOCK);

    getBorderImage("res://block_resources/block_textures/border.png");


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
                
                Ref<Image> blockImg = cock->getTextureImage(blockID);
                
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

                // unrotate it, this is hacky i know
                if (rotate){ 
                    for(int g = 0; g < blockSide; g++){
                        blockImg->rotate_90(ClockDirection::COUNTERCLOCKWISE);
                    }
                }

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
                
                Ref<Image> blockImg = cock->getTextureImage(backBlockID);

                bool rotate = cock->isGravityRotate(backBlockID);
                if (rotate){ 
                    for(int g = 0; g < blockSide; g++){
                        blockImg->rotate_90(ClockDirection::CLOCKWISE);
                    }
                }

                int frame = 0;
                if( cock->isConnectedTexture(backBlockID) ) { frame = scanBackOpen(planet,worldX,worldY); }
                Rect2i blockRect = Rect2i(frame,0,8,8);

                backImg->blend_rect(blockImg, blockRect, imgPos);

                Vector2i scan = scanForBorder(planet,worldX,worldY);

                backImg->blend_rect(texImage, Rect2i(scan.x,scan.y,8,8), imgPos);

                // unrotate it
                if (rotate){ 
                    for(int g = 0; g < blockSide; g++){
                        blockImg->rotate_90(ClockDirection::COUNTERCLOCKWISE);
                    }
                }

            }

        }
    }


    //emit_signal("chunkDrawn", this, img, backImg);


    images.append(img);
    images.append(backImg);

   return images;

}

Array CHUNKDRAW::tickUpdate(PLANETDATA *planet,Vector2i pos){

    Array collectedChanges;

    for(int x = 0; x < 8; x++){
        for(int y = 0; y < 8; y++){
            int worldX = x+(pos.x*8);
            int worldY = y+(pos.y*8);

            int planetSize = planet->planetSize; // GETS PASSED IN
            
            int blockID = planet->getTileData(worldX,worldY);

            int blockSide = planet->getPositionLookup(worldX,worldY);


            collectedChanges.append( cock->runOnTick(worldX,worldY,planet,blockSide,blockID) );

            // SIMULATE LIGHT //

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

   return collectedChanges;
        
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

int CHUNKDRAW::scanBackOpen(PLANETDATA *planet,int x,int y){
	int openL = 1;
	int openR = 2;
	int openT = 4;
	int openB = 8;
	//what the fuck is this

    int blockID = planet->getBGData(x-1,y);
    int connectTexturesToMe = !cock->isTextureConnector(blockID);
    openL = 1 * connectTexturesToMe;

    blockID = planet->getBGData(x+1,y);
    connectTexturesToMe = !cock->isTextureConnector(blockID);
    openR = 2 * connectTexturesToMe;


    blockID = planet->getBGData(x,y-1);
    connectTexturesToMe = !cock->isTextureConnector(blockID);
    openT = 4 * connectTexturesToMe;

    blockID = planet->getBGData(x,y+1);
    connectTexturesToMe = !cock->isTextureConnector(blockID);
    openB = 8 * connectTexturesToMe;

	return (openL + openR + openT + openB) * 8;
}

Vector2i CHUNKDRAW::scanForBorder(PLANETDATA *planet,int x,int y){
	int openL = 1;
	int openR = 2;
	int openT = 4;
	int openB = 8;
	
    int openTL = 1;
	int openTR = 2;
	int openBL = 4;
	int openBR = 8;


    // Straight Directionals
    int blockID = planet->getBGData(x-1,y);
    int connectTexturesToMe = blockID < 2;
    openL = 1 * connectTexturesToMe;

    blockID = planet->getBGData(x+1,y);
    connectTexturesToMe = blockID < 2;
    openR = 2 * connectTexturesToMe;

    blockID = planet->getBGData(x,y-1);
    connectTexturesToMe = blockID < 2;
    openT = 4 * connectTexturesToMe;

    blockID = planet->getBGData(x,y+1);
    connectTexturesToMe = blockID < 2;
    openB = 8 * connectTexturesToMe;

    // Diagonal Directionals
    blockID = planet->getBGData(x-1,y-1);
    connectTexturesToMe = blockID < 2;
    openTL = 1 * connectTexturesToMe;

    blockID = planet->getBGData(x+1,y-1);
    connectTexturesToMe = blockID < 2;
    openTR = 2 * connectTexturesToMe;

    blockID = planet->getBGData(x-1,y+1);
    connectTexturesToMe = blockID < 2;
    openBL = 4 * connectTexturesToMe;

    blockID = planet->getBGData(x+1,y+1);
    connectTexturesToMe = blockID < 2;
    openBR = 8 * connectTexturesToMe;

	return Vector2i((openL + openR + openT + openB) * 8 , (openTL + openTR + openBL + openBR) * 8 ) ;
}

Dictionary CHUNKDRAW::runBreak(PLANETDATA *planet,Vector2i pos,int x, int y, int blockID){

    int blockSide = planet->getPositionLookup(x,y);

    return cock->runOnBreak(x,y,planet,blockSide,blockID);
        
}

void CHUNKDRAW::getBorderImage( const char* file ) {
    ResourceLoader rl;
    texture = rl.load(file);

    texImage = texture->get_image();
    texImage->convert(Image::FORMAT_RGBA8);

}