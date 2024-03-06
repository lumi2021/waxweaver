#ifndef BLOCKTREEBRANCHLEAF_H
#define BLOCKTREEBRANCHLEAF_H

#include "block.h"

namespace godot {

class BLOCKTREEBRANCHLEAF : public BLOCK {
	GDCLASS(BLOCKTREEBRANCHLEAF, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKTREEBRANCHLEAF();
	~BLOCKTREEBRANCHLEAF();

	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif