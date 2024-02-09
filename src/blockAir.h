#ifndef BLOCKAIR_H
#define BLOCKAIR_H

#include "block.h"

namespace godot {

class BLOCKAIR : public BLOCK {
	GDCLASS(BLOCKAIR, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKAIR();
	~BLOCKAIR();

};

}

#endif