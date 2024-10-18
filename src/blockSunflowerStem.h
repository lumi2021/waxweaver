#ifndef BLOCKSUNFLOWERSTEM_H
#define BLOCKSUNFLOWERSTEM_H

#include "block.h"

namespace godot {

class BLOCKSUNFLOWERSTEM : public BLOCK {
	GDCLASS(BLOCKSUNFLOWERSTEM, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKSUNFLOWERSTEM();
	~BLOCKSUNFLOWERSTEM();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif