#ifndef BLOCKPLASMA_H
#define BLOCKPLASMA_H

#include "block.h"

namespace godot {

class BLOCKPLASMA : public BLOCK {
	GDCLASS(BLOCKPLASMA, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPLASMA();
	~BLOCKPLASMA();

};

}

#endif