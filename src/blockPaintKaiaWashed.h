#ifndef BLOCKPAINTKAIAWASHED_H
#define BLOCKPAINTKAIAWASHED_H

#include "block.h"

namespace godot {

class BLOCKPAINTKAIAWASHED : public BLOCK {
	GDCLASS(BLOCKPAINTKAIAWASHED, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPAINTKAIAWASHED();
	~BLOCKPAINTKAIAWASHED();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif