#ifndef BLOCKWORKBENCH_H
#define BLOCKWORKBENCH_H

#include "block.h"

namespace godot {

class BLOCKWORKBENCH : public BLOCK {
	GDCLASS(BLOCKWORKBENCH, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKWORKBENCH();
	~BLOCKWORKBENCH();

	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif