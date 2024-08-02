#ifndef BLOCKBARIRON_H
#define BLOCKBARIRON_H

#include "block.h"

namespace godot {

class BLOCKBARIRON : public BLOCK {
	GDCLASS(BLOCKBARIRON, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKBARIRON();
	~BLOCKBARIRON();

};

}

#endif