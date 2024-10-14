#ifndef BLOCKBED_H
#define BLOCKBED_H

#include "block.h"

namespace godot {

class BLOCKBED : public BLOCK {
	GDCLASS(BLOCKBED, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKBED();
	~BLOCKBED();

	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif