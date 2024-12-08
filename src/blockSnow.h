#ifndef BLOCKSNOW_H
#define BLOCKSNOW_H

#include "block.h"

namespace godot {

class BLOCKSNOW : public BLOCK {
	GDCLASS(BLOCKSNOW, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKSNOW();
	~BLOCKSNOW();

};

}

#endif