#ifndef BLOCKSOIL_H
#define BLOCKSOIL_H

#include "block.h"

namespace godot {

class BLOCKSOIL : public BLOCK {
	GDCLASS(BLOCKSOIL, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKSOIL();
	~BLOCKSOIL();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif