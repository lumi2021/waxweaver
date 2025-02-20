#ifndef BLOCKTRAPFIREBALL_H
#define BLOCKTRAPFIREBALL_H

#include "block.h"

namespace godot {

class BLOCKTRAPFIREBALL : public BLOCK {
	GDCLASS(BLOCKTRAPFIREBALL, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKTRAPFIREBALL();
	~BLOCKTRAPFIREBALL();

	Dictionary onEnergize(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif