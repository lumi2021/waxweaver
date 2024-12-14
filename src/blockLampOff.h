#ifndef BLOCKLAMPOFF_H
#define BLOCKLAMPOFF_H

#include "block.h"

namespace godot {

class BLOCKLAMPOFF : public BLOCK {
	GDCLASS(BLOCKLAMPOFF, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKLAMPOFF();
	~BLOCKLAMPOFF();

	Dictionary onEnergize(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif