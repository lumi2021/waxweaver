#ifndef BLOCKSAPLING_H
#define BLOCKSAPLING_H

#include "block.h"

namespace godot {

class BLOCKSAPLING : public BLOCK {
	GDCLASS(BLOCKSAPLING, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKSAPLING();
	~BLOCKSAPLING();

    Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif