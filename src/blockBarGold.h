#ifndef BLOCKBARGOLD_H
#define BLOCKBARGOLD_H

#include "block.h"

namespace godot {

class BLOCKBARGOLD : public BLOCK {
	GDCLASS(BLOCKBARGOLD, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKBARGOLD();
	~BLOCKBARGOLD();

};

}

#endif