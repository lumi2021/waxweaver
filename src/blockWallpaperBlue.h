#ifndef BLOCKWALLPAPERBLUE_H
#define BLOCKWALLPAPERBLUE_H

#include "block.h"

namespace godot {

class BLOCKWALLPAPERBLUE : public BLOCK {
	GDCLASS(BLOCKWALLPAPERBLUE, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKWALLPAPERBLUE();
	~BLOCKWALLPAPERBLUE();

};

}

#endif