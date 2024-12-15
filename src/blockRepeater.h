#ifndef BLOCKREPEATER_H
#define BLOCKREPEATER_H

#include "block.h"

namespace godot {

class BLOCKREPEATER : public BLOCK {
	GDCLASS(BLOCKREPEATER, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKREPEATER();
	~BLOCKREPEATER();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);
	Dictionary onEnergize(int x, int y, PLANETDATA *planet, int dir);
};

}

#endif