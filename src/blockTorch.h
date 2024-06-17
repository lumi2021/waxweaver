#ifndef BLOCKTORCH_H
#define BLOCKTORCH_H

#include "block.h"

namespace godot {

class BLOCKTORCH : public BLOCK {
	GDCLASS(BLOCKTORCH, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKTORCH();
	~BLOCKTORCH();

};

}

#endif