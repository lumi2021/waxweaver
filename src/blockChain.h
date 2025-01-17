#ifndef BLOCKCHAIN_H
#define BLOCKCHAIN_H

#include "block.h"

namespace godot {

class BLOCKCHAIN : public BLOCK {
	GDCLASS(BLOCKCHAIN, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKCHAIN();
	~BLOCKCHAIN();

};

}

#endif