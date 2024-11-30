#ifndef BLOCKMAGICINFUSER_H
#define BLOCKMAGICINFUSER_H

#include "block.h"

namespace godot {

class BLOCKMAGICINFUSER : public BLOCK {
	GDCLASS(BLOCKMAGICINFUSER, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKMAGICINFUSER();
	~BLOCKMAGICINFUSER();

	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif