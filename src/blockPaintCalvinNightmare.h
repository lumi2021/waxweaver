#ifndef BLOCKPAINTCALVINNIGHTMARE_H
#define BLOCKPAINTCALVINNIGHTMARE_H

#include "block.h"

namespace godot {

class BLOCKPAINTCALVINNIGHTMARE : public BLOCK {
	GDCLASS(BLOCKPAINTCALVINNIGHTMARE, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPAINTCALVINNIGHTMARE();
	~BLOCKPAINTCALVINNIGHTMARE();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif