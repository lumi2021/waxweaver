#ifndef BLOCKTROPHY_H
#define BLOCKTROPHY_H

#include "block.h"

namespace godot {

class BLOCKTROPHY : public BLOCK {
	GDCLASS(BLOCKTROPHY, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKTROPHY();
	~BLOCKTROPHY();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif