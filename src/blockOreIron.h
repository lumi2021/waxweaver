#ifndef BLOCKOREIRON_H
#define BLOCKOREIRON_H

#include "block.h"

namespace godot {

class BLOCKOREIRON : public BLOCK {
	GDCLASS(BLOCKOREIRON, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKOREIRON();
	~BLOCKOREIRON();

};

}

#endif