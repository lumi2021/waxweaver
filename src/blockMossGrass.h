#ifndef BLOCKMOSSGRASS_H
#define BLOCKMOSSGRASS_H

#include "block.h"

namespace godot {

class BLOCKMOSSGRASS : public BLOCK {
	GDCLASS(BLOCKMOSSGRASS, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKMOSSGRASS();
	~BLOCKMOSSGRASS();

    Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif