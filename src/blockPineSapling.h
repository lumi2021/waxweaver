#ifndef BLOCKPINESAPLING_H
#define BLOCKPINESAPLING_H

#include "block.h"

namespace godot {

class BLOCKPINESAPLING : public BLOCK {
	GDCLASS(BLOCKPINESAPLING, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPINESAPLING();
	~BLOCKPINESAPLING();

    Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif