#ifndef BLOCKAMECRYSTAL_H
#define BLOCKAMECRYSTAL_H

#include "block.h"

namespace godot {

class BLOCKAMECRYSTAL : public BLOCK {
	GDCLASS(BLOCKAMECRYSTAL, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKAMECRYSTAL();
	~BLOCKAMECRYSTAL();

    Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif