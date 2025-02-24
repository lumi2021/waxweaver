#ifndef BLOCKPAINTSTAGSEEN_H
#define BLOCKPAINTSTAGSEEN_H

#include "block.h"

namespace godot {

class BLOCKPAINTSTAGSEEN : public BLOCK {
	GDCLASS(BLOCKPAINTSTAGSEEN, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPAINTSTAGSEEN();
	~BLOCKPAINTSTAGSEEN();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif