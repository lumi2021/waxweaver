#ifndef BLOCKFLOWERPOT_H
#define BLOCKFLOWERPOT_H

#include "block.h"

namespace godot {

class BLOCKFLOWERPOT : public BLOCK {
	GDCLASS(BLOCKFLOWERPOT, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKFLOWERPOT();
	~BLOCKFLOWERPOT();

};

}

#endif