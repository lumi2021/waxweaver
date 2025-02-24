#ifndef BLOCKPAINTSTAGFISH_H
#define BLOCKPAINTSTAGFISH_H

#include "block.h"

namespace godot {

class BLOCKPAINTSTAGFISH : public BLOCK {
	GDCLASS(BLOCKPAINTSTAGFISH, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPAINTSTAGFISH();
	~BLOCKPAINTSTAGFISH();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif