#ifndef BLOCKSOLDERINGIRON_H
#define BLOCKSOLDERINGIRON_H

#include "block.h"

namespace godot {

class BLOCKSOLDERINGIRON : public BLOCK {
	GDCLASS(BLOCKSOLDERINGIRON, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKSOLDERINGIRON();
	~BLOCKSOLDERINGIRON();

};

}

#endif