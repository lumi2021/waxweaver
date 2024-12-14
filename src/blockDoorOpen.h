#ifndef BLOCKDOOROPEN_H
#define BLOCKDOOROPEN_H

#include "block.h"

namespace godot {

class BLOCKDOOROPEN : public BLOCK {
	GDCLASS(BLOCKDOOROPEN, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKDOOROPEN();
	~BLOCKDOOROPEN();

	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onEnergize(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif