#ifndef BLOCKMARBLE_H
#define BLOCKMARBLE_H

#include "block.h"

namespace godot {

class BLOCKMARBLE : public BLOCK {
	GDCLASS(BLOCKMARBLE, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKMARBLE();
	~BLOCKMARBLE();

};

}

#endif