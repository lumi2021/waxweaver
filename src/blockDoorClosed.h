#ifndef BLOCKDOORCLOSED_H
#define BLOCKDOORCLOSED_H

#include "block.h"

namespace godot {

class BLOCKDOORCLOSED : public BLOCK {
	GDCLASS(BLOCKDOORCLOSED, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKDOORCLOSED();
	~BLOCKDOORCLOSED();

	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onEnergize(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif