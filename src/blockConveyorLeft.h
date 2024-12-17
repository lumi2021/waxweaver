#ifndef BLOCKCONVEYORLEFT_H
#define BLOCKCONVEYORLEFT_H

#include "block.h"

namespace godot {

class BLOCKCONVEYORLEFT : public BLOCK {
	GDCLASS(BLOCKCONVEYORLEFT, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKCONVEYORLEFT();
	~BLOCKCONVEYORLEFT();

	//Dictionary onEnergize(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif