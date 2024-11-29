#ifndef BLOCKMOSSORB_H
#define BLOCKMOSSORB_H

#include "block.h"

namespace godot {

class BLOCKMOSSORB : public BLOCK {
	GDCLASS(BLOCKMOSSORB, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKMOSSORB();
	~BLOCKMOSSORB();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif