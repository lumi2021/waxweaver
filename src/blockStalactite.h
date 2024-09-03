#ifndef BLOCKSTALACTITE_H
#define BLOCKSTALACTITE_H

#include "block.h"

namespace godot {

class BLOCKSTALACTITE : public BLOCK {
	GDCLASS(BLOCKSTALACTITE, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKSTALACTITE();
	~BLOCKSTALACTITE();

    Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif