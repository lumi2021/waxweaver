#ifndef BLOCKCLOCK_H
#define BLOCKCLOCK_H

#include "block.h"

namespace godot {

class BLOCKCLOCK : public BLOCK {
	GDCLASS(BLOCKCLOCK, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKCLOCK();
	~BLOCKCLOCK();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif