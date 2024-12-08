#ifndef BLOCKCALCITE_H
#define BLOCKCALCITE_H

#include "block.h"

namespace godot {

class BLOCKCALCITE : public BLOCK {
	GDCLASS(BLOCKCALCITE, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKCALCITE();
	~BLOCKCALCITE();

	Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif