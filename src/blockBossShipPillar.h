#ifndef BLOCKBOSSSHIPPILLAR_H
#define BLOCKBOSSSHIPPILLAR_H

#include "block.h"

namespace godot {

class BLOCKBOSSSHIPPILLAR : public BLOCK {
	GDCLASS(BLOCKBOSSSHIPPILLAR, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKBOSSSHIPPILLAR();
	~BLOCKBOSSSHIPPILLAR();

	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif