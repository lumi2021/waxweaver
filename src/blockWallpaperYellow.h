#ifndef BLOCKWALLPAPERYELLOW_H
#define BLOCKWALLPAPERYELLOW_H

#include "block.h"

namespace godot {

class BLOCKWALLPAPERYELLOW : public BLOCK {
	GDCLASS(BLOCKWALLPAPERYELLOW, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKWALLPAPERYELLOW();
	~BLOCKWALLPAPERYELLOW();

};

}

#endif