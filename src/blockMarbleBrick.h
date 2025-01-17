#ifndef BLOCKMARBLEBRICK_H
#define BLOCKMARBLEBRICK_H

#include "block.h"

namespace godot {

class BLOCKMARBLEBRICK : public BLOCK {
	GDCLASS(BLOCKMARBLEBRICK, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKMARBLEBRICK();
	~BLOCKMARBLEBRICK();

};

}

#endif