#ifndef BLOCKCLAY_H
#define BLOCKCLAY_H

#include "block.h"

namespace godot {

class BLOCKCLAY : public BLOCK {
	GDCLASS(BLOCKCLAY, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKCLAY();
	~BLOCKCLAY();

};

}

#endif