#ifndef BLOCKSAND_H
#define BLOCKSAND_H

#include "block.h"

namespace godot {

class BLOCKSAND : public BLOCK {
	GDCLASS(BLOCKSAND, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKSAND();
	~BLOCKSAND();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif