#ifndef BLOCKPAINTTILTROKIWI_H
#define BLOCKPAINTTILTROKIWI_H

#include "block.h"

namespace godot {

class BLOCKPAINTTILTROKIWI : public BLOCK {
	GDCLASS(BLOCKPAINTTILTROKIWI, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPAINTTILTROKIWI();
	~BLOCKPAINTTILTROKIWI();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif