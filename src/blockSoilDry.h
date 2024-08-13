#ifndef BLOCKSOILDRY_H
#define BLOCKSOILDRY_H

#include "block.h"

namespace godot {

class BLOCKSOILDRY : public BLOCK {
	GDCLASS(BLOCKSOILDRY, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKSOILDRY();
	~BLOCKSOILDRY();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif