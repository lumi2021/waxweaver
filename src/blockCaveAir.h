#ifndef BLOCKCAVEAIR_H
#define BLOCKCAVEAIR_H

#include "block.h"

namespace godot {

class BLOCKCAVEAIR : public BLOCK {
	GDCLASS(BLOCKCAVEAIR, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKCAVEAIR();
	~BLOCKCAVEAIR();

};

}

#endif