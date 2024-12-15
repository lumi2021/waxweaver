#ifndef BLOCKDRILL_H
#define BLOCKDRILL_H

#include "block.h"

namespace godot {

class BLOCKDRILL : public BLOCK {
	GDCLASS(BLOCKDRILL, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKDRILL();
	~BLOCKDRILL();

	Dictionary onEnergize(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif