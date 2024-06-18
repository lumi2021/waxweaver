#ifndef BLOCKTALLGRASS_H
#define BLOCKTALLGRASS_H

#include "block.h"

namespace godot {

class BLOCKTALLGRASS : public BLOCK {
	GDCLASS(BLOCKTALLGRASS, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKTALLGRASS();
	~BLOCKTALLGRASS();

    Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif