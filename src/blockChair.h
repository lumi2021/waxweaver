#ifndef BLOCKCHAIR_H
#define BLOCKCHAIR_H

#include "block.h"

namespace godot {

class BLOCKCHAIR : public BLOCK {
	GDCLASS(BLOCKCHAIR, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKCHAIR();
	~BLOCKCHAIR();

	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif