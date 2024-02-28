#ifndef PLANETGEN_H
#define PLANETGEN_H

#include <godot_cpp/variant/vector2i.hpp>
#include <godot_cpp/variant/vector2.hpp>
#include <godot_cpp/classes/sprite2d.hpp>
#include <godot_cpp/classes/fast_noise_lite.hpp>

#include <algorithm>

#include "planetData.h"

namespace godot {

class PLANETGEN : public Sprite2D {
	GDCLASS(PLANETGEN, Sprite2D)

private:

protected:
	static void _bind_methods();

public:
	PLANETGEN();
	~PLANETGEN();

    void generateForestPlanet(PLANETDATA *planet, FastNoiseLite *noise);
    void generateLunarPlanet(PLANETDATA *planet, FastNoiseLite *noise);
    
    
    double getBlockDistance(int x, int y, PLANETDATA *planet);
	
};

}

#endif