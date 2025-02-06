#ifndef BLOCKSANDSTONEBRICK_H
#define BLOCKSANDSTONEBRICK_H

#include "block.h"

namespace godot {

class BLOCKSANDSTONEBRICK : public BLOCK {
	GDCLASS(BLOCKSANDSTONEBRICK, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKSANDSTONEBRICK();
	~BLOCKSANDSTONEBRICK();

};

}

#endif