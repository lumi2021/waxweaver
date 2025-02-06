#ifndef BLOCKGRASSDESERT_H
#define BLOCKGRASSDESERT_H

#include "block.h"

namespace godot {

class BLOCKGRASSDESERT : public BLOCK {
	GDCLASS(BLOCKGRASSDESERT, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKGRASSDESERT();
	~BLOCKGRASSDESERT();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif