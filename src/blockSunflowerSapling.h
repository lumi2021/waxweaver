#ifndef BLOCKSUNFLOWERSAPLING_H
#define BLOCKSUNFLOWERSAPLING_H

#include "block.h"

namespace godot {

class BLOCKSUNFLOWERSAPLING : public BLOCK {
	GDCLASS(BLOCKSUNFLOWERSAPLING, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKSUNFLOWERSAPLING();
	~BLOCKSUNFLOWERSAPLING();

    Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif