#ifndef BLOCKOREFOSSIL_H
#define BLOCKOREFOSSIL_H

#include "block.h"

namespace godot {

class BLOCKOREFOSSIL : public BLOCK {
	GDCLASS(BLOCKOREFOSSIL, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKOREFOSSIL();
	~BLOCKOREFOSSIL();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif