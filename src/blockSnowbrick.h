#ifndef BLOCKSNOWBRICK_H
#define BLOCKSNOWBRICK_H

#include "block.h"

namespace godot {

class BLOCKSNOWBRICK : public BLOCK {
	GDCLASS(BLOCKSNOWBRICK, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKSNOWBRICK();
	~BLOCKSNOWBRICK();

};

}

#endif