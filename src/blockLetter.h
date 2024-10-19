#ifndef BLOCKLETTER_H
#define BLOCKLETTER_H

#include "block.h"

namespace godot {

class BLOCKLETTER : public BLOCK {
	GDCLASS(BLOCKLETTER, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKLETTER();
	~BLOCKLETTER();

};

}

#endif