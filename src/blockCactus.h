#ifndef BLOCKCACTUS_H
#define BLOCKCACTUS_H

#include "block.h"

namespace godot {

class BLOCKCACTUS : public BLOCK {
	GDCLASS(BLOCKCACTUS, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKCACTUS();
	~BLOCKCACTUS();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif