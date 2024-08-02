#ifndef BLOCKSTONEBRICK_H
#define BLOCKSTONEBRICK_H

#include "block.h"

namespace godot {

class BLOCKSTONEBRICK : public BLOCK {
	GDCLASS(BLOCKSTONEBRICK, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKSTONEBRICK();
	~BLOCKSTONEBRICK();

};

}

#endif