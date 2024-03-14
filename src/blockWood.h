#ifndef BLOCKWOOD_H
#define BLOCKWOOD_H

#include "block.h"

namespace godot {

class BLOCKWOOD : public BLOCK {
	GDCLASS(BLOCKWOOD, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKWOOD();
	~BLOCKWOOD();

};

}

#endif