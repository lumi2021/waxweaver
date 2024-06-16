#ifndef BLOCKTABLEWOOD_H
#define BLOCKSTONE_H

#include "block.h"

namespace godot {

class BLOCKTABLEWOOD : public BLOCK {
	GDCLASS(BLOCKTABLEWOOD, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKTABLEWOOD();
	~BLOCKTABLEWOOD();

};

}

#endif