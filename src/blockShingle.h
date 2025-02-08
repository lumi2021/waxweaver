#ifndef BLOCKSHINGLE_H
#define BLOCKSHINGLE_H

#include "block.h"

namespace godot {

class BLOCKSHINGLE : public BLOCK {
	GDCLASS(BLOCKSHINGLE, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKSHINGLE();
	~BLOCKSHINGLE();

};

}

#endif