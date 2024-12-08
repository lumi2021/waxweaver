#ifndef BLOCKCOREGRASS_H
#define BLOCKCOREGRASS_H

#include "block.h"

namespace godot {

class BLOCKCOREGRASS : public BLOCK {
	GDCLASS(BLOCKCOREGRASS, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKCOREGRASS();
	~BLOCKCOREGRASS();

    Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif