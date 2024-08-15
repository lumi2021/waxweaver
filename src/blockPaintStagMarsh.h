#ifndef BLOCKPAINTSTAGMARSH_H
#define BLOCKPAINTSTAGMARSH_H

#include "block.h"

namespace godot {

class BLOCKPAINTSTAGMARSH : public BLOCK {
	GDCLASS(BLOCKPAINTSTAGMARSH, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPAINTSTAGMARSH();
	~BLOCKPAINTSTAGMARSH();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif