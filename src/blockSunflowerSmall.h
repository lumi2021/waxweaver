#ifndef BLOCKSUNFLOWERSMALL_H
#define BLOCKSUNFLOWERSMALL_H

#include "block.h"

namespace godot {

class BLOCKSUNFLOWERSMALL : public BLOCK {
	GDCLASS(BLOCKSUNFLOWERSMALL, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKSUNFLOWERSMALL();
	~BLOCKSUNFLOWERSMALL();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif