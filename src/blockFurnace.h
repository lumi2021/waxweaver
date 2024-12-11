#ifndef BLOCKFURNACE_H
#define BLOCKFURNACE_H

#include "block.h"

namespace godot {

class BLOCKFURNACE : public BLOCK {
	GDCLASS(BLOCKFURNACE, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKFURNACE();
	~BLOCKFURNACE();

	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif