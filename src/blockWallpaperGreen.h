#ifndef BLOCKWALLPAPERGREEN_H
#define BLOCKWALLPAPERGREEN_H

#include "block.h"

namespace godot {

class BLOCKWALLPAPERGREEN : public BLOCK {
	GDCLASS(BLOCKWALLPAPERGREEN, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKWALLPAPERGREEN();
	~BLOCKWALLPAPERGREEN();

};

}

#endif