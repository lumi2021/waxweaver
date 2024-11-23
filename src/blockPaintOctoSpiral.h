#ifndef BLOCKPAINTOCTOSPIRAL_H
#define BLOCKPAINTOCTOSPIRAL_H

#include "block.h"

namespace godot {

class BLOCKPAINTOCTOSPIRAL : public BLOCK {
	GDCLASS(BLOCKPAINTOCTOSPIRAL, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPAINTOCTOSPIRAL();
	~BLOCKPAINTOCTOSPIRAL();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif