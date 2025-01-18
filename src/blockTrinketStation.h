#ifndef BLOCKTRINKETSTATION_H
#define BLOCKTRINKETSTATION_H

#include "block.h"

namespace godot {

class BLOCKTRINKETSTATION : public BLOCK {
	GDCLASS(BLOCKTRINKETSTATION, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKTRINKETSTATION();
	~BLOCKTRINKETSTATION();

	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif