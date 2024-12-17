#ifndef BLOCKEXTENDER_H
#define BLOCKEXTENDER_H

#include "block.h"

namespace godot {

class BLOCKEXTENDER : public BLOCK {
	GDCLASS(BLOCKEXTENDER, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKEXTENDER();
	~BLOCKEXTENDER();

	Dictionary onEnergize(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif