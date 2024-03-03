#ifndef BLOCKTREEBRANCHRIGHT_H
#define BLOCKTREEBRANCHRIGHT_H

#include "block.h"

namespace godot {

class BLOCKTREEBRANCHRIGHT : public BLOCK {
	GDCLASS(BLOCKTREEBRANCHRIGHT, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKTREEBRANCHRIGHT();
	~BLOCKTREEBRANCHRIGHT();

};

}

#endif