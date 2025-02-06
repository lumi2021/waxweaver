#ifndef BLOCKPINKWOOD_H
#define BLOCKPINKWOOD_H

#include "block.h"

namespace godot {

class BLOCKPINKWOOD : public BLOCK {
	GDCLASS(BLOCKPINKWOOD, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPINKWOOD();
	~BLOCKPINKWOOD();

};

}

#endif