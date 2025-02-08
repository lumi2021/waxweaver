#ifndef BLOCKSHOPCOMPUTERON_H
#define BLOCKSHOPCOMPUTERON_H

#include "block.h"

namespace godot {

class BLOCKSHOPCOMPUTERON : public BLOCK {
	GDCLASS(BLOCKSHOPCOMPUTERON, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKSHOPCOMPUTERON();
	~BLOCKSHOPCOMPUTERON();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif