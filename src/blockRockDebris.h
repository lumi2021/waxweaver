#ifndef BLOCKROCKDEBRIS_H
#define BLOCKROCKDEBRIS_H

#include "block.h"

namespace godot {

class BLOCKROCKDEBRIS : public BLOCK {
	GDCLASS(BLOCKROCKDEBRIS, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKROCKDEBRIS();
	~BLOCKROCKDEBRIS();

    Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif