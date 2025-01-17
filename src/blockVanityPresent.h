#ifndef BLOCKVANITYPRESENT_H
#define BLOCKVANITYPRESENT_H

#include "block.h"

namespace godot {

class BLOCKVANITYPRESENT : public BLOCK {
	GDCLASS(BLOCKVANITYPRESENT, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKVANITYPRESENT();
	~BLOCKVANITYPRESENT();

    
};

}

#endif