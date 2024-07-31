#ifndef BLOCKFLOWER_H
#define BLOCKFLOWER_H

#include "block.h"

namespace godot {

class BLOCKFLOWER : public BLOCK {
	GDCLASS(BLOCKFLOWER, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKFLOWER();
	~BLOCKFLOWER();

    Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif