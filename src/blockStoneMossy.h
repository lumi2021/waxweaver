#ifndef BLOCKSTONEMOSSY_H
#define BLOCKSTONEMOSSY_H

#include "block.h"

namespace godot {

class BLOCKSTONEMOSSY : public BLOCK {
	GDCLASS(BLOCKSTONEMOSSY, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKSTONEMOSSY();
	~BLOCKSTONEMOSSY();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif