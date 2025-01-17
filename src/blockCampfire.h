#ifndef BLOCKCAMPFIRE_H
#define BLOCKCAMPFIRE_H

#include "block.h"

namespace godot {

class BLOCKCAMPFIRE : public BLOCK {
	GDCLASS(BLOCKCAMPFIRE, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKCAMPFIRE();
	~BLOCKCAMPFIRE();

	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif