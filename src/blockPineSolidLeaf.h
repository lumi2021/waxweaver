#ifndef BLOCKPINESOLIDLEAF_H
#define BLOCKPINESOLIDLEAF_H

#include "block.h"

namespace godot {

class BLOCKPINESOLIDLEAF : public BLOCK {
	GDCLASS(BLOCKPINESOLIDLEAF, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPINESOLIDLEAF();
	~BLOCKPINESOLIDLEAF();

	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif