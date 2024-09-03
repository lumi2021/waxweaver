#ifndef BLOCKPAINTLYNSMILE_H
#define BLOCKPAINTLYNSMILE_H

#include "block.h"

namespace godot {

class BLOCKPAINTLYNSMILE : public BLOCK {
	GDCLASS(BLOCKPAINTLYNSMILE, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPAINTLYNSMILE();
	~BLOCKPAINTLYNSMILE();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif