#ifndef BLOCKGRASS_H
#define BLOCKGRASS_H

#include "block.h"

namespace godot {

class BLOCKGRASS : public BLOCK {
	GDCLASS(BLOCKGRASS, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKGRASS();
	~BLOCKGRASS();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif