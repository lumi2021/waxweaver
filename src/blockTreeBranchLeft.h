#ifndef BLOCKTREEBRANCHLEFT_H
#define BLOCKTREEBRANCHLEFT_H

#include "block.h"

namespace godot {

class BLOCKTREEBRANCHLEFT : public BLOCK {
	GDCLASS(BLOCKTREEBRANCHLEFT, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKTREEBRANCHLEFT();
	~BLOCKTREEBRANCHLEFT();

};

}

#endif