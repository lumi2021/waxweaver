#ifndef BLOCKPINKTREESAPLING_H
#define BLOCKPINKTREESAPLING_H

#include "block.h"

namespace godot {

class BLOCKPINKTREESAPLING : public BLOCK {
	GDCLASS(BLOCKPINKTREESAPLING, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPINKTREESAPLING();
	~BLOCKPINKTREESAPLING();

    Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif