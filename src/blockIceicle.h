#ifndef BLOCKICEICLE_H
#define BLOCKICEICLE_H

#include "block.h"

namespace godot {

class BLOCKICEICLE : public BLOCK {
	GDCLASS(BLOCKICEICLE, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKICEICLE();
	~BLOCKICEICLE();

    Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif