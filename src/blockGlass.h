#ifndef BLOCKGLASS_H
#define BLOCKGLASS_H

#include "block.h"

namespace godot {

class BLOCKGLASS : public BLOCK {
	GDCLASS(BLOCKGLASS, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKGLASS();
	~BLOCKGLASS();

};

}

#endif