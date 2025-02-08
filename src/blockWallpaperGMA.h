#ifndef BLOCKWALLPAPERGMA_H
#define BLOCKWALLPAPERGMA_H

#include "block.h"

namespace godot {

class BLOCKWALLPAPERGMA : public BLOCK {
	GDCLASS(BLOCKWALLPAPERGMA, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKWALLPAPERGMA();
	~BLOCKWALLPAPERGMA();

};

}

#endif