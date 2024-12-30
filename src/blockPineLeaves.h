#ifndef BLOCKPINELEAVES_H
#define BLOCKPINELEAVES_H

#include "block.h"

namespace godot {

class BLOCKPINELEAVES : public BLOCK {
	GDCLASS(BLOCKPINELEAVES, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPINELEAVES();
	~BLOCKPINELEAVES();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif