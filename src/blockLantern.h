#ifndef BLOCKLANTERN_H
#define BLOCKLANTERN_H

#include "block.h"

namespace godot {

class BLOCKLANTERN : public BLOCK {
	GDCLASS(BLOCKLANTERN, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKLANTERN();
	~BLOCKLANTERN();

};

}

#endif