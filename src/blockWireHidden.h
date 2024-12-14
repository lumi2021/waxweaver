#ifndef BLOCKWIREHIDDEN_H
#define BLOCKWIREHIDDEN_H

#include "block.h"

namespace godot {

class BLOCKWIREHIDDEN : public BLOCK {
	GDCLASS(BLOCKWIREHIDDEN, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKWIREHIDDEN();
	~BLOCKWIREHIDDEN();

	Dictionary onEnergize(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif