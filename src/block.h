#ifndef BLOCK_H
#define BLOCK_H

#include <algorithm>
#include <godot_cpp/classes/texture2d.hpp>
#include <godot_cpp/classes/image.hpp>
#include <godot_cpp/classes/resource_loader.hpp>
#include <godot_cpp/classes/resource.hpp>
#include <godot_cpp/variant/array.hpp>
#include <godot_cpp/variant/dictionary.hpp>
#include <godot_cpp/variant/vector2i.hpp>

#include "planetData.h"

namespace godot {

class BLOCK : public Resource {
	GDCLASS(BLOCK, Resource)

private:
	

protected:
	static void _bind_methods();

public:

    int blockID;

    Ref<Texture2D> texture;
    Ref<Image> texImage;
    bool rotateTextureToGravity;
    bool connectedTexture;
    bool connectTexturesToMe;

    bool hasCollision;

    double lightMultiplier;
    double lightEmmission;

    int itemToDrop;

    int breakParticleID;

    double breakTime;


	BLOCK();
	~BLOCK();

    void setNewVariables();
    void setTexture( const char* file );

    virtual Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);



};

}

#endif