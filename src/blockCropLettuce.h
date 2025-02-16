#ifndef BLOCKCROPLETTUCE_H
#define BLOCKCROPLETTUCE_H

#include "block.h"

namespace godot {

class BLOCKCROPLETTUCE : public BLOCK {
	GDCLASS(BLOCKCROPLETTUCE, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKCROPLETTUCE();
	~BLOCKCROPLETTUCE();

    Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif