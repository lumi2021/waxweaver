#ifndef BLOCKOREFIBER_H
#define BLOCKOREFIBER_H

#include "block.h"

namespace godot {

class BLOCKOREFIBER : public BLOCK {
	GDCLASS(BLOCKOREFIBER, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKOREFIBER();
	~BLOCKOREFIBER();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif