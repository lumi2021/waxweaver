#ifndef BLOCKSTONE_H
#define BLOCKSTONE_H

#include "block.h"

namespace godot {

class BLOCKSTONE : public BLOCK {
	GDCLASS(BLOCKSTONE, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKSTONE();
	~BLOCKSTONE();

};

}

#endif