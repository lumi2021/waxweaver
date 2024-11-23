#ifndef BLOCKPAINTCALVINSUNRISE_H
#define BLOCKPAINTCALVINSUNRISE_H

#include "block.h"

namespace godot {

class BLOCKPAINTCALVINSUNRISE : public BLOCK {
	GDCLASS(BLOCKPAINTCALVINSUNRISE, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKPAINTCALVINSUNRISE();
	~BLOCKPAINTCALVINSUNRISE();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onBreak(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif