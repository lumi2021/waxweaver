#ifndef BLOCKINFOSCANNER_H
#define BLOCKINFOSCANNER_H

#include "block.h"

namespace godot {

class BLOCKINFOSCANNER : public BLOCK {
	GDCLASS(BLOCKINFOSCANNER, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKINFOSCANNER();
	~BLOCKINFOSCANNER();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif