#ifndef BLOCKMINIBOSSSPAWNER_H
#define BLOCKMINIBOSSSPAWNER_H

#include "block.h"

namespace godot {

class BLOCKMINIBOSSSPAWNER : public BLOCK {
	GDCLASS(BLOCKMINIBOSSSPAWNER, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKMINIBOSSSPAWNER();
	~BLOCKMINIBOSSSPAWNER();

};

}

#endif