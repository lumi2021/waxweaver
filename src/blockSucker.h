#ifndef BLOCKSUCKER_H
#define BLOCKSUCKER_H

#include "block.h"

namespace godot {

class BLOCKSUCKER : public BLOCK {
	GDCLASS(BLOCKSUCKER, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKSUCKER();
	~BLOCKSUCKER();

	Dictionary onEnergize(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif