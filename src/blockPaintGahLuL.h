#ifndef BLOCKPAINTGAHLUL_H
#define BLOCKPAINTGAHLUL_H

#include "block.h"

namespace godot {

class BLOCKPAINTGAHLUL : public BLOCK {
	GDCLASS(BLOCKPAINTGAHLUL, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPAINTGAHLUL();
	~BLOCKPAINTGAHLUL();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif