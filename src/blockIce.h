#ifndef BLOCKICE_H
#define BLOCKICE_H

#include "block.h"

namespace godot {

class BLOCKICE : public BLOCK {
	GDCLASS(BLOCKICE, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKICE();
	~BLOCKICE();

};

}

#endif