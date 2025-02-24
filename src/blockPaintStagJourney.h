#ifndef BLOCKPAINTSTAGJOURNEY_H
#define BLOCKPAINTSTAGJOURNEY_H

#include "block.h"

namespace godot {

class BLOCKPAINTSTAGJOURNEY : public BLOCK {
	GDCLASS(BLOCKPAINTSTAGJOURNEY, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPAINTSTAGJOURNEY();
	~BLOCKPAINTSTAGJOURNEY();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif