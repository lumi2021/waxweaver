#ifndef BLOCKPAINTLYNWORN_H
#define BLOCKPAINTLYNWORN_H

#include "block.h"

namespace godot {

class BLOCKPAINTLYNWORN : public BLOCK {
	GDCLASS(BLOCKPAINTLYNWORN, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPAINTLYNWORN();
	~BLOCKPAINTLYNWORN();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif