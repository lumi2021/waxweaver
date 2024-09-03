#ifndef BLOCKPAINTLYNFISH_H
#define BLOCKPAINTLYNFISH_H

#include "block.h"

namespace godot {

class BLOCKPAINTLYNFISH : public BLOCK {
	GDCLASS(BLOCKPAINTLYNFISH, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPAINTLYNFISH();
	~BLOCKPAINTLYNFISH();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif