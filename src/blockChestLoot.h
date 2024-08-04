#ifndef BLOCKCHESTLOOT_H
#define BLOCKCHESTLOOT_H

#include "block.h"

namespace godot {

class BLOCKCHESTLOOT : public BLOCK {
	GDCLASS(BLOCKCHESTLOOT, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKCHESTLOOT();
	~BLOCKCHESTLOOT();

};

}

#endif