#ifndef BLOCKLADDERPACK_H
#define BLOCKLADDERPACK_H

#include "block.h"

namespace godot {

class BLOCKLADDERPACK : public BLOCK {
	GDCLASS(BLOCKLADDERPACK, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKLADDERPACK();
	~BLOCKLADDERPACK();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif