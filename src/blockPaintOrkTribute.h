#ifndef BLOCKPAINTORKTRIBUTE_H
#define BLOCKPAINTORKTRIBUTE_H

#include "block.h"

namespace godot {

class BLOCKPAINTORKTRIBUTE : public BLOCK {
	GDCLASS(BLOCKPAINTORKTRIBUTE, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPAINTORKTRIBUTE();
	~BLOCKPAINTORKTRIBUTE();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif