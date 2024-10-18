#ifndef BLOCKSUNFLOWERTOP_H
#define BLOCKSUNFLOWERTOP_H

#include "block.h"

namespace godot {

class BLOCKSUNFLOWERTOP : public BLOCK {
	GDCLASS(BLOCKSUNFLOWERTOP, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKSUNFLOWERTOP();
	~BLOCKSUNFLOWERTOP();

};

}

#endif