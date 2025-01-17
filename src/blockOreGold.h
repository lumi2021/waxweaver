#ifndef BLOCKOREGOLD_H
#define BLOCKOREGOLD_H

#include "block.h"

namespace godot {

class BLOCKOREGOLD : public BLOCK {
	GDCLASS(BLOCKOREGOLD, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKOREGOLD();
	~BLOCKOREGOLD();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif