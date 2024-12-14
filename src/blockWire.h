#ifndef BLOCKWIRE_H
#define BLOCKWIRE_H

#include "block.h"

namespace godot {

class BLOCKWIRE : public BLOCK {
	GDCLASS(BLOCKWIRE, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKWIRE();
	~BLOCKWIRE();

	Dictionary onEnergize(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif