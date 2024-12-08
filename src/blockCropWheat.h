#ifndef BLOCKCROPWHEAT_H
#define BLOCKCROPWHEAT_H

#include "block.h"

namespace godot {

class BLOCKCROPWHEAT : public BLOCK {
	GDCLASS(BLOCKCROPWHEAT, BLOCK)

private:
	

protected:
	static void _bind_methods();

public:
	BLOCKCROPWHEAT();
	~BLOCKCROPWHEAT();

    Dictionary onTick(int x, int y, PLANETDATA *planet, int dir);

};

}

#endif