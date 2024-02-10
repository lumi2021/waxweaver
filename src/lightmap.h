#ifndef LIGHTMAP_H
#define LIGHTMAP_H

#include <godot_cpp/classes/sprite2d.hpp>
#include <godot_cpp/classes/image.hpp>
#include <godot_cpp/variant/array.hpp>
#include <godot_cpp/classes/image_texture.hpp>
//#include <godot_cpp/classes/ref.hpp>

namespace godot {

class LIGHTMAP : public Sprite2D {
	GDCLASS(LIGHTMAP, Sprite2D)

private:
    Array planetData;
    Ref<Image> img = nullptr;


protected:
	static void _bind_methods();

public:
	LIGHTMAP();
    ~LIGHTMAP();

    void generateLightTexture(int x, int y,Array lightData);

    void _process(double delta) override;
};

}

#endif