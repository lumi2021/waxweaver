#ifndef BLOCKLEVER_H
#define BLOCKLEVER_H

#include "block.h"

namespace godot {

class BLOCKLEVER : public BLOCK {
	GDCLASS(BLOCKLEVER, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKLEVER();
	~BLOCKLEVER();

};

}

#endif