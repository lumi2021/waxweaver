#ifndef BLOCKSEAGRASS_H
#define BLOCKSEAGRASS_H

#include "block.h"

namespace godot {

class BLOCKSEAGRASS : public BLOCK {
	GDCLASS(BLOCKSEAGRASS, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKSEAGRASS();
	~BLOCKSEAGRASS();

    Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif