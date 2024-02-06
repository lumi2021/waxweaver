#ifndef CHUNKDRAW_H
#define CHUNKDRAW_H

#include <godot_cpp/classes/sprite2d.hpp>

namespace godot {

class CHUNKDRAW : public Sprite2D {
	GDCLASS(CHUNKDRAW, Sprite2D)

private:
	double time_passed;

protected:
	static void _bind_methods();

public:
	CHUNKDRAW();
	~CHUNKDRAW();

    int generateTexturesFromData(Array planetData,Vector2i pos,Array positionLookup[][128]);

	void _process(double delta) override;
};

}

#endif