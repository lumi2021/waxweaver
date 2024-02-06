#ifndef LIGHTMAP_H
#define LIGHTMAP_H

#include <godot_cpp/classes/sprite2d.hpp>
#include <godot_cpp/classes/image.hpp>
#include <godot_cpp/variant/array.hpp>
#include <godot_cpp/classes/image_texture.hpp>

namespace godot {

class LIGHTMAP : public Sprite2D {
	GDCLASS(LIGHTMAP, Sprite2D)

private:
	double time_passed;
    Array planetData;

protected:
	static void _bind_methods();

public:
	LIGHTMAP();

    <Ref>ImageTexture generateLightTexture(int x, int y,Array lightData,Array);

};

}

#endif