#ifndef BLOCKBRICK_H
#define BLOCKBRICK_H

#include "block.h"

namespace godot {

class BLOCKBRICK : public BLOCK {
	GDCLASS(BLOCKBRICK, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKBRICK();
	~BLOCKBRICK();

};

}

#endif