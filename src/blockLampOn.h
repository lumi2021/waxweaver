#ifndef BLOCKLAMPON_H
#define BLOCKLAMPON_H

#include "block.h"

namespace godot {

class BLOCKLAMPON : public BLOCK {
	GDCLASS(BLOCKLAMPON, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKLAMPON();
	~BLOCKLAMPON();

	Dictionary onEnergize(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif