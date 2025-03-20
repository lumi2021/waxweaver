#ifndef BLOCKNUMBERSCANNER_H
#define BLOCKNUMBERSCANNER_H

#include "block.h"

namespace godot {

class BLOCKNUMBERSCANNER : public BLOCK {
	GDCLASS(BLOCKNUMBERSCANNER, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKNUMBERSCANNER();
	~BLOCKNUMBERSCANNER();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif