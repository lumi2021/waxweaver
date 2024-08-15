#ifndef BLOCKPAINTSTAGPLUMP_H
#define BLOCKPAINTSTAGPLUMP_H

#include "block.h"

namespace godot {

class BLOCKPAINTSTAGPLUMP : public BLOCK {
	GDCLASS(BLOCKPAINTSTAGPLUMP, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPAINTSTAGPLUMP();
	~BLOCKPAINTSTAGPLUMP();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif