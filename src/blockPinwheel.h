#ifndef BLOCKPINWHEEL_H
#define BLOCKPINWHEEL_H

#include "block.h"

namespace godot {

class BLOCKPINWHEEL : public BLOCK {
	GDCLASS(BLOCKPINWHEEL, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPINWHEEL();
	~BLOCKPINWHEEL();

	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onLoad(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif