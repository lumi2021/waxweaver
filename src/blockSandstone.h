#ifndef BLOCKSANDSTONE_H
#define BLOCKSANDSTONE_H

#include "block.h"

namespace godot {

class BLOCKSANDSTONE : public BLOCK {
	GDCLASS(BLOCKSANDSTONE, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKSANDSTONE();
	~BLOCKSANDSTONE();

};

}

#endif