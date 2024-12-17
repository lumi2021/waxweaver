#ifndef BLOCKCONVEYORRIGHT_H
#define BLOCKCONVEYORRIGHT_H

#include "block.h"

namespace godot {

class BLOCKCONVEYORRIGHT : public BLOCK {
	GDCLASS(BLOCKCONVEYORRIGHT, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKCONVEYORRIGHT();
	~BLOCKCONVEYORRIGHT();

	//Dictionary onEnergize(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif