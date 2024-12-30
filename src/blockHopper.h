#ifndef BLOCKHOPPER_H
#define BLOCKHOPPER_H

#include "block.h"

namespace godot {

class BLOCKHOPPER : public BLOCK {
	GDCLASS(BLOCKHOPPER, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKHOPPER();
	~BLOCKHOPPER();

	Dictionary onEnergize(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif