#ifndef BLOCKPAINTORKPILL_H
#define BLOCKPAINTORKPILL_H

#include "block.h"

namespace godot {

class BLOCKPAINTORKPILL : public BLOCK {
	GDCLASS(BLOCKPAINTORKPILL, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPAINTORKPILL();
	~BLOCKPAINTORKPILL();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif