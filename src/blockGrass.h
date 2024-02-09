#ifndef BLOCKGRASS_H
#define BLOCKGRASS_H

#include "block.h"

namespace godot {

class BLOCKGRASS : public BLOCK {
	GDCLASS(BLOCKGRASS, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKGRASS();
	~BLOCKGRASS();

};

}

#endif