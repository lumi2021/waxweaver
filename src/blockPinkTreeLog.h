#ifndef BLOCKPINKTREELOG_H
#define BLOCKPINKTREELOG_H

#include "block.h"

namespace godot {

class BLOCKPINKTREELOG : public BLOCK {
	GDCLASS(BLOCKPINKTREELOG, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPINKTREELOG();
	~BLOCKPINKTREELOG();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif