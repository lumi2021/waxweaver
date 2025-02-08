#ifndef BLOCKBLACKSTONE_H
#define BLOCKBLACKSTONE_H

#include "block.h"

namespace godot {

class BLOCKBLACKSTONE : public BLOCK {
	GDCLASS(BLOCKBLACKSTONE, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKBLACKSTONE();
	~BLOCKBLACKSTONE();

};

}

#endif