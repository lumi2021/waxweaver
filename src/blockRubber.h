#ifndef BLOCKRUBBER_H
#define BLOCKRUBBER_H

#include "block.h"

namespace godot {

class BLOCKRUBBER : public BLOCK {
	GDCLASS(BLOCKRUBBER, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKRUBBER();
	~BLOCKRUBBER();

	Dictionary onEnergize(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif