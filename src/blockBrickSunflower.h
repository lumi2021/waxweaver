#ifndef BLOCKBRICKSUNFLOWER_H
#define BLOCKBRICKSUNFLOWER_H

#include "block.h"

namespace godot {

class BLOCKBRICKSUNFLOWER : public BLOCK {
	GDCLASS(BLOCKBRICKSUNFLOWER, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKBRICKSUNFLOWER();
	~BLOCKBRICKSUNFLOWER();

};

}

#endif