#ifndef BLOCKDIRT_H
#define BLOCKDIRT_H

#include "block.h"

namespace godot {

class BLOCKDIRT : public BLOCK {
	GDCLASS(BLOCKDIRT, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKDIRT();
	~BLOCKDIRT();

};

}

#endif