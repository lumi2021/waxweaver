#ifndef BLOCKSPITTER_H
#define BLOCKSPITTER_H

#include "block.h"

namespace godot {

class BLOCKSPITTER : public BLOCK {
	GDCLASS(BLOCKSPITTER, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKSPITTER();
	~BLOCKSPITTER();

	Dictionary onEnergize(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif