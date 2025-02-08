#ifndef BLOCKSHOPCOMPUTER_H
#define BLOCKSHOPCOMPUTER_H

#include "block.h"

namespace godot {

class BLOCKSHOPCOMPUTER : public BLOCK {
	GDCLASS(BLOCKSHOPCOMPUTER, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKSHOPCOMPUTER();
	~BLOCKSHOPCOMPUTER();

};

}

#endif