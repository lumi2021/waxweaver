#ifndef BLOCKPAINTSTAGCUP_H
#define BLOCKPAINTSTAGCUP_H

#include "block.h"

namespace godot {

class BLOCKPAINTSTAGCUP : public BLOCK {
	GDCLASS(BLOCKPAINTSTAGCUP, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPAINTSTAGCUP();
	~BLOCKPAINTSTAGCUP();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif