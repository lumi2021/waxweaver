#ifndef BLOCKTRAPDOORCLOSED_H
#define BLOCKTRAPDOORCLOSED_H

#include "block.h"

namespace godot {

class BLOCKTRAPDOORCLOSED : public BLOCK {
	GDCLASS(BLOCKTRAPDOORCLOSED, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKTRAPDOORCLOSED();
	~BLOCKTRAPDOORCLOSED();

};

}

#endif