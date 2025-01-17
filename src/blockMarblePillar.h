#ifndef BLOCKMARBLEPILLAR_H
#define BLOCKMARBLEPILLAR_H

#include "block.h"

namespace godot {

class BLOCKMARBLEPILLAR : public BLOCK {
	GDCLASS(BLOCKMARBLEPILLAR, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKMARBLEPILLAR();
	~BLOCKMARBLEPILLAR();

};

}

#endif