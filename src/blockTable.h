#ifndef BLOCKTABLE_H
#define BLOCKTABLE_H

#include "block.h"

namespace godot {

class BLOCKTABLE : public BLOCK {
	GDCLASS(BLOCKTABLE, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKTABLE();
	~BLOCKTABLE();

	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif