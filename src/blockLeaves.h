#ifndef BLOCKLEAVES_H
#define BLOCKLEAVES_H

#include "block.h"

namespace godot {

class BLOCKLEAVES : public BLOCK {
	GDCLASS(BLOCKLEAVES, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKLEAVES();
	~BLOCKLEAVES();

};

}

#endif