#ifndef BLOCKLEAVESSTATIC_H
#define BLOCKLEAVESSTATIC_H

#include "block.h"

namespace godot {

class BLOCKLEAVESSTATIC : public BLOCK {
	GDCLASS(BLOCKLEAVESSTATIC, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKLEAVESSTATIC();
	~BLOCKLEAVESSTATIC();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif