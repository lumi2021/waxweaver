#ifndef BLOCKPAINTSTAGDAWN_H
#define BLOCKPAINTSTAGDAWN_H

#include "block.h"

namespace godot {

class BLOCKPAINTSTAGDAWN : public BLOCK {
	GDCLASS(BLOCKPAINTSTAGDAWN, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPAINTSTAGDAWN();
	~BLOCKPAINTSTAGDAWN();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif