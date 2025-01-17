#ifndef BLOCKORECOPPER_H
#define BLOCKORECOPPER_H

#include "block.h"

namespace godot {

class BLOCKORECOPPER : public BLOCK {
	GDCLASS(BLOCKORECOPPER, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKORECOPPER();
	~BLOCKORECOPPER();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif