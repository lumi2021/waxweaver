#ifndef BLOCKMOSSVINE_H
#define BLOCKMOSSVINE_H

#include "block.h"

namespace godot {

class BLOCKMOSSVINE : public BLOCK {
	GDCLASS(BLOCKMOSSVINE, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKMOSSVINE();
	~BLOCKMOSSVINE();

    Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif