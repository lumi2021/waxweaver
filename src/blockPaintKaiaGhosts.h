#ifndef BLOCKPAINTKAIAGHOSTS_H
#define BLOCKPAINTKAIAGHOSTS_H

#include "block.h"

namespace godot {

class BLOCKPAINTKAIAGHOSTS : public BLOCK {
	GDCLASS(BLOCKPAINTKAIAGHOSTS, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPAINTKAIAGHOSTS();
	~BLOCKPAINTKAIAGHOSTS();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif