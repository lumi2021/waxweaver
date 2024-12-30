#ifndef BLOCKTRAPDOOROPEN_H
#define BLOCKTRAPDOOROPEN_H

#include "block.h"

namespace godot {

class BLOCKTRAPDOOROPEN : public BLOCK {
	GDCLASS(BLOCKTRAPDOOROPEN, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKTRAPDOOROPEN();
	~BLOCKTRAPDOOROPEN();

	Dictionary onEnergize(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif