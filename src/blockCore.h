#ifndef BLOCKCORE_H
#define BLOCKCORE_H

#include "block.h"

namespace godot {

class BLOCKCORE : public BLOCK {
	GDCLASS(BLOCKCORE, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKCORE();
	~BLOCKCORE();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif