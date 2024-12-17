#ifndef BLOCKPLACER_H
#define BLOCKPLACER_H

#include "block.h"

namespace godot {

class BLOCKPLACER : public BLOCK {
	GDCLASS(BLOCKPLACER, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPLACER();
	~BLOCKPLACER();

	Dictionary onEnergize(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif