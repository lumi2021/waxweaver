#ifndef BLOCKBOOK_H
#define BLOCKBOOK_H

#include "block.h"

namespace godot {

class BLOCKBOOK : public BLOCK {
	GDCLASS(BLOCKBOOK, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKBOOK();
	~BLOCKBOOK();

};

}

#endif