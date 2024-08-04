#ifndef BLOCKCHEST_H
#define BLOCKCHEST_H

#include "block.h"

namespace godot {

class BLOCKCHEST : public BLOCK {
	GDCLASS(BLOCKCHEST, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKCHEST();
	~BLOCKCHEST();

};

}

#endif