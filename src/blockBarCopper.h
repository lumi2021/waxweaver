#ifndef BLOCKBARCOPPER_H
#define BLOCKBARCOPPER_H

#include "block.h"

namespace godot {

class BLOCKBARCOPPER : public BLOCK {
	GDCLASS(BLOCKBARCOPPER, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKBARCOPPER();
	~BLOCKBARCOPPER();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif