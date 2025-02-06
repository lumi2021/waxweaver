#ifndef BLOCKPINKTREELEAVES_H
#define BLOCKPINKTREELEAVES_H

#include "block.h"

namespace godot {

class BLOCKPINKTREELEAVES : public BLOCK {
	GDCLASS(BLOCKPINKTREELEAVES, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPINKTREELEAVES();
	~BLOCKPINKTREELEAVES();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif