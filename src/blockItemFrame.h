#ifndef BLOCKITEMFRAME_H
#define BLOCKITEMFRAME_H

#include "block.h"

namespace godot {

class BLOCKITEMFRAME : public BLOCK {
	GDCLASS(BLOCKITEMFRAME, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKITEMFRAME();
	~BLOCKITEMFRAME();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onLoad(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif