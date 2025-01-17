#ifndef BLOCKGRANDFATHERCLOCK_H
#define BLOCKGRANDFATHERCLOCK_H

#include "block.h"

namespace godot {

class BLOCKGRANDFATHERCLOCK : public BLOCK {
	GDCLASS(BLOCKGRANDFATHERCLOCK, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKGRANDFATHERCLOCK();
	~BLOCKGRANDFATHERCLOCK();

	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif