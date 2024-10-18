#ifndef BLOCKSUNFLOWERLEAF_H
#define BLOCKSUNFLOWERLEAF_H

#include "block.h"

namespace godot {

class BLOCKSUNFLOWERLEAF : public BLOCK {
	GDCLASS(BLOCKSUNFLOWERLEAF, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKSUNFLOWERLEAF();
	~BLOCKSUNFLOWERLEAF();

};

}

#endif