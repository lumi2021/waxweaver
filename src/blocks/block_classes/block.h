#ifndef BLOCK_H
#define BLOCK_H

#include <godot_cpp/classes/image.hpp>
#include <godot_cpp/classes/resource_loader.hpp>
#include <godot_cpp/classes/resource.hpp>
#include <godot_cpp/variant/array.hpp>
#include <godot_cpp/variant/dictionary.hpp>

namespace godot {

class Block : public Resource {
	GDCLASS(Block, Resource)

private:
	int blockID;

    Ref<Image> textureImage;
    bool rotateTextureToGravity;
    bool connectedTexture;
    bool connectTexturesToMe;

    bool hasCollision;

    double lightMultiplier;
    double lightEmmission;

    int itemToDrop;

    int breakParticleID;

    double breakTime;

protected:
	static void _bind_methods();

public:
	BLOCK();
	~BLOCK();

    Dictionary onTick(int x, int y, Array planetData, int layer, int dir);

};

}

#endif