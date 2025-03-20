#ifndef BLOCKTABLEPINK_H
#define BLOCKTABLEPINK_H

#include "block.h"

namespace godot {

class BLOCKTABLEPINK : public BLOCK {
	GDCLASS(BLOCKTABLEPINK, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKTABLEPINK();
	~BLOCKTABLEPINK();

	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif