#ifndef BLOCKTABLEWOOD_H
#define BLOCKTABLEWOOD_H

#include "block.h"

namespace godot {

class BLOCKTABLEWOOD : public BLOCK {
	GDCLASS(BLOCKTABLEWOOD, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKTABLEWOOD();
	~BLOCKTABLEWOOD();

	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif