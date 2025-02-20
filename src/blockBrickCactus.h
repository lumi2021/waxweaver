#ifndef BLOCKBRICKCACTUS_H
#define BLOCKBRICKCACTUS_H

#include "block.h"

namespace godot {

class BLOCKBRICKCACTUS : public BLOCK {
	GDCLASS(BLOCKBRICKCACTUS, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKBRICKCACTUS();
	~BLOCKBRICKCACTUS();

};

}

#endif