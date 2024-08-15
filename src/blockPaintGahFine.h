#ifndef BLOCKPAINTGAHFINE_H
#define BLOCKPAINTGAHFINE_H

#include "block.h"

namespace godot {

class BLOCKPAINTGAHFINE : public BLOCK {
	GDCLASS(BLOCKPAINTGAHFINE, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPAINTGAHFINE();
	~BLOCKPAINTGAHFINE();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif