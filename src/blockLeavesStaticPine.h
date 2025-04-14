#ifndef BLOCKLEAVESSTATICPINE_H
#define BLOCKLEAVESSTATICPINE_H

#include "block.h"

namespace godot {

class BLOCKLEAVESSTATICPINE : public BLOCK {
	GDCLASS(BLOCKLEAVESSTATICPINE, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKLEAVESSTATICPINE();
	~BLOCKLEAVESSTATICPINE();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif