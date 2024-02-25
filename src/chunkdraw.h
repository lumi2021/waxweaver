#ifndef CHUNKDRAW_H
#define CHUNKDRAW_H

#include <godot_cpp/classes/sprite2d.hpp>
#include <godot_cpp/classes/image.hpp>
#include <godot_cpp/classes/resource_loader.hpp>
#include <godot_cpp/classes/resource.hpp>
#include <godot_cpp/classes/texture2d.hpp>
#include <godot_cpp/variant/array.hpp>
#include <godot_cpp/variant/rect2i.hpp>

#include <godot_cpp/classes/static_body2d.hpp>
#include <godot_cpp/classes/collision_shape2d.hpp>
#include <godot_cpp/classes/rectangle_shape2d.hpp>

#include <algorithm>

#include "lookupBlock.h"
#include "planetData.h"

namespace godot {

class CHUNKDRAW : public Sprite2D {
	GDCLASS(CHUNKDRAW, Sprite2D)

private:
	double time_passed;
    Array planetData;
	LOOKUPBLOCK *cock;

protected:
	static void _bind_methods();

public:
	CHUNKDRAW();
	~CHUNKDRAW();

    Array generateTexturesFromData(PLANETDATA *planet,Vector2i pos,Node *body,Ref<Shape2D> shape);
	Array tickUpdate(PLANETDATA *planet,Vector2i pos);

	int scanBlockOpen(PLANETDATA *planet,int x,int y);
	Dictionary getBlockDictionary(int id);
};

}

#endif