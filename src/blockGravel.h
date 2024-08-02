#ifndef BLOCKGRAVEL_H
#define BLOCKGRAVEL_H

#include "block.h"

namespace godot {

class BLOCKGRAVEL : public BLOCK {
	GDCLASS(BLOCKGRAVEL, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKGRAVEL();
	~BLOCKGRAVEL();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif