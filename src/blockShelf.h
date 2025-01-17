#ifndef BLOCKSHELF_H
#define BLOCKSHELF_H

#include "block.h"

namespace godot {

class BLOCKSHELF : public BLOCK {
	GDCLASS(BLOCKSHELF, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKSHELF();
	~BLOCKSHELF();

};

}

#endif