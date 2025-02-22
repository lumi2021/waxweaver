#ifndef BLOCKPAINTEELWORKOUTGUY_H
#define BLOCKPAINTEELWORKOUTGUY_H

#include "block.h"

namespace godot {

class BLOCKPAINTEELWORKOUTGUY : public BLOCK {
	GDCLASS(BLOCKPAINTEELWORKOUTGUY, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPAINTEELWORKOUTGUY();
	~BLOCKPAINTEELWORKOUTGUY();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif