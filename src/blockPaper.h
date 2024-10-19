#ifndef BLOCKPAPER_H
#define BLOCKPAPER_H

#include "block.h"

namespace godot {

class BLOCKPAPER : public BLOCK {
	GDCLASS(BLOCKPAPER, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPAPER();
	~BLOCKPAPER();

};

}

#endif