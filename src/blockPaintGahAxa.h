#ifndef BLOCKPAINTGAHAXA_H
#define BLOCKPAINTGAHAXA_H

#include "block.h"

namespace godot {

class BLOCKPAINTGAHAXA : public BLOCK {
	GDCLASS(BLOCKPAINTGAHAXA, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPAINTGAHAXA();
	~BLOCKPAINTGAHAXA();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif