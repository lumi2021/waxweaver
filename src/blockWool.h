#ifndef BLOCKWOOL_H
#define BLOCKWOOL_H

#include "block.h"

namespace godot {

class BLOCKWOOL : public BLOCK {
	GDCLASS(BLOCKWOOL, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKWOOL();
	~BLOCKWOOL();

};

}

#endif