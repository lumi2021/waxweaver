#ifndef BLOCKPINKTREEFLOWERING_H
#define BLOCKPINKTREEFLOWERING_H

#include "block.h"

namespace godot {

class BLOCKPINKTREEFLOWERING : public BLOCK {
	GDCLASS(BLOCKPINKTREEFLOWERING, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPINKTREEFLOWERING();
	~BLOCKPINKTREEFLOWERING();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif