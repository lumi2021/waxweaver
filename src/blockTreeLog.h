#ifndef BLOCKTREELOG_H
#define BLOCKTREELOG_H

#include "block.h"

namespace godot {

class BLOCKTREELOG : public BLOCK {
	GDCLASS(BLOCKTREELOG, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKTREELOG();
	~BLOCKTREELOG();

};

}

#endif